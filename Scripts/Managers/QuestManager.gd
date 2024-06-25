class_name QuestManager
extends Node

var active_quests : Array[QuestData]
var finished_quests : Array[QuestData]

func _ready():
	load_quests_from_save_file(true, "active_quests")
	load_quests_from_save_file(true, "finished_quests")
	SignalBusSingleton.update_all_quests.emit(self, active_quests, finished_quests)
	SignalBusSingleton.update_one_quest.connect(on_update_one_quest)
	SignalBusSingleton.unlock_quest.connect(on_unlock_quest)
	pass
	
func load_quests_from_save_file(default : bool, dictionary_id : String) -> void:
	var quest_dictionary : Dictionary = {}
	var save_file_name : String = DynamicDataSingleton.quest_file_name
	var save_directory_name : String = AppSettingsSingleton.quests_data_folder_path
	if default:
		quest_dictionary = DynamicDataSingleton.load_save(quest_dictionary, save_file_name, save_directory_name, true)
	if quest_dictionary[dictionary_id].size() > 0:
		for quest in quest_dictionary[dictionary_id]:
			var new_quest_data = QuestData.new()
			new_quest_data.quest_id = quest["id"]
			new_quest_data.quest_title = quest["title"]
			new_quest_data.quest_description = quest["description"]
			for step in quest["steps"]:
				var new_step_data = QuestStepComponent.new()
				new_step_data.id = step["id"]
				new_step_data.description = step["description"]
				for objective in step["objectives"]:
					var new_objective_data = QuestObjectiveComponent.new()
					new_objective_data.id = objective["id"]
					new_objective_data.title = objective["title"]
					new_objective_data.description = objective["description"]
					for char in objective["characters"]:
						new_objective_data.characters.append(char)
					for res in objective["results"]:
						new_objective_data.results.append(res)
					new_objective_data.mandatory = objective["mandatory"]
					new_objective_data.success = objective["success"]
					new_step_data.objectives.append(new_objective_data)
				new_step_data.active = step["active"]
				new_quest_data.quest_steps.append(new_step_data)
			for res in quest["results"]:
				new_quest_data.quest_results.append(res)
			new_quest_data.quest_active = quest["active"]
			active_quests.append(new_quest_data)
	else:
		UtilsSingleton.log_data(self, "load_quests_from_save_file", "No quest found in '" + dictionary_id +"'.")

func save_quests() -> void:
	var quests_dictionary : Dictionary = { "active_quests" : active_quests, "finished_quests" : finished_quests }
	var save_file_name : String = DynamicDataSingleton.quest_file_name
	DynamicDataSingleton.save(save_file_name, quests_dictionary)


#Quest/Step/Objectives validation
func validate_objective(quest_id : String, step_id : String, objective_index : int):
	for quest in active_quests:
		if quest.id == quest_id:
			for step in quest.steps:
				if step.id == step_id:
					step.objectives[objective_index].success = true
					UtilsSingleton.log_data(self, "validate_objective", "Objective '" + step.objectives[objective_index].title + "' has been updated")

func check_step_success(quest_id : String, step_id : String)-> bool:
	var quest : QuestData = find_quest_by_id(quest_id)
	if quest != null:
		var step : QuestStepComponent = find_step_by_id(step_id, quest.quest_steps)
		if step != null:
			for objective in step.objectives: 
				if !objective.success: 
					return false
			return true
		else:
			UtilsSingleton.log_error(self, "check_step_success", "No quest found with id " + quest_id)
			return false		
	else:
		UtilsSingleton.log_error(self, "check_step_success", "No quest found with id " + quest_id)
		return false
	
func check_quest_success(quest_id : String) -> bool:
	for quest in active_quests:
		if quest.id == quest_id:
			for step in quest.steps:
				if !check_step_success(quest.id, step.id):
					return false
				return true
	return false

func find_objectives_ids_by_char_id(character_id : String) -> Array[String]:
	var objectives_ids : Array[String]
	for quest in active_quests:
		for step in quest.steps:
			for objective in step.objectives:
				if objective.characters.find(character_id) > -1:
					objectives_ids.append(quest.quest_id + "_" + step.id + "_" + objective.id)
					UtilsSingleton.log_error(self, "find_objectives_ids_by_char_id", "'" + objective.id + "' was added to the list of objectives.")
	return objectives_ids

func find_quest_by_id(quest_id : String):
	for quest in active_quests:
		if quest.quest_id == quest_id:
			return quest
		else:
			UtilsSingleton.log_error(self, "find_quest_by_id", "The id " + quest_id + " was not found in the active quests")

func find_step_by_id(step_id : String, steps : Array[QuestStepComponent]):
	for step in steps:
		if step.step_id == step_id:
			return step
		else:
			UtilsSingleton.log_error(self, "find_step_by_id", "The id " + step_id + " was not found in the quest's steps")



#Signal callables
func on_update_one_quest(emitter : Node, objective_id : String):
	#TODO 
	#1 Decompose the id to find the correct quest, correct step, then correct objective
	#2 put it to success = true + manage the results of said objective
	#3 check_step_success - check if all objectives are done: if yes, make step as success = true
	#4 check_quest_success - check if all steps are done: if yes, make quest as success = true and put in finished quests
	pass

func on_unlock_quest(emitter : Node, quest_id : String):
	var quest_data : Dictionary = {}
	quest_data = %QuestData.load_quest_data(quest_id)
	quest_data.active = true
	quest_data.steps[0].active = true
	active_quests.append(quest_data)
	UtilsSingleton.log_data(self, "on_unlock_quest", active_quests)
