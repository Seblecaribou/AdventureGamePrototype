class_name QuestManager
extends Node

var active_quests : Array[QuestData]
var finished_quests : Array[QuestData]
var current_objectives : Array[QuestObjectiveComponent]

func _ready():
	load_quests_from_save_file(true, "active_quests")
	load_quests_from_save_file(true, "finished_quests")
	SignalBusSingleton.update_all_quests.emit(self, active_quests, finished_quests)
	SignalBusSingleton.update_one_quest.connect(_on_update_one_quest)
	SignalBusSingleton.unlock_quest.connect(_on_unlock_quest)
	SignalBusSingleton.goal_validated.connect(_on_goal_validated)
	pass

#region Methods
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

func check_objective_goal(goal_id : String) -> void:
	for objective in current_objectives:
		if goal_id == objective.goal:
			validate_objective(objective.id)

#Quest/Step/Objectives validation methods
func validate_objective(objective_id : String) -> void:
	for quest in active_quests:
		for step in quest.quest_steps:
				for objective in step.objectives:
					if objective.id == objective_id:
						var quest_id = quest.quest_id
						var step_id = step.id
						objective.success = true
						UtilsSingleton.log_data(self, "validate_objective", "Objective '" + objective.title + "' has been updated")
						check_step_success(quest_id, step_id)

func check_step_success(quest_id : String, step_id : String) -> bool:
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
			
func find_objective_by_id(obj_id : String, objectives : Array[QuestObjectiveComponent]):
	for obj in objectives:
		if obj.id == obj_id:
			return obj
		else : 
			UtilsSingleton.log_error(self, "find_objective_by_id", "The id " + obj_id + " was not found in the quest's objectives")
			
func manage_result(result_id : String) -> void:
	var result_type : String = result_id.get_slice("_", 0)
	match result_type:
		"suc":
			#Success - Resolves another quest
			pass
		"unl":
			#Unlock - Unlocks a quest
			pass
		"tak":
			#Take - Adds an item to inventory
			pass
		"giv":
			#Give - Gives an item to NPC / Removes item from inventory
			pass
		"cut":
			#Cutscene - Loads a cutscene
			pass
	pass
#endregion


#region Signal Callback functions
func _on_goal_validated(emitter : Node, goal_id : String) -> void:
	check_objective_goal(goal_id)

func _on_update_one_quest(emitter : Node, objective_id : String) -> void:
	#TODO 
	#1 Decompose the id to find the correct quest, correct step, then correct objective
	var quest_id : String = objective_id.get_slice("_",0)
	var quest : QuestData = find_quest_by_id(quest_id)
	
	var step_id : String = objective_id.get_slice("_",1)
	var step : QuestStepComponent = find_step_by_id(step_id, quest.quest_steps)
	
	var obj_id : String = objective_id.get_slice("_",2)
	var objective : QuestObjectiveComponent = find_objective_by_id(obj_id, step.objectives)
	
	objective.success = true
	for result in objective.results:
		manage_result(result)
	
	step.active = check_step_success(quest_id, step_id)
	for index in quest.size():
		if index + 1 != quest.size():
			if quest.quest_steps[index].id == step_id:
				quest.quest_steps[index + 1].active = true
		else :
			quest.active = !check_quest_success(quest_id)


func _on_unlock_quest(emitter : Node, quest_id : String):
	var quest_data : Dictionary = {}
	quest_data = %QuestData.load_quest_data(quest_id)
	quest_data.active = true
	quest_data.steps[0].active = true
	active_quests.append(quest_data)
	UtilsSingleton.log_data(self, "on_unlock_quest", active_quests)
#endregion
