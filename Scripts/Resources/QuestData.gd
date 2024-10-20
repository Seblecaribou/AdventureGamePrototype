class_name QuestData
extends Node

var quest_id : String
var quest_title : String
var quest_description : String
var quest_steps : Array[QuestStepComponent]
var quest_results : Array[String]
var quest_active : bool


func load_quest_data(id : String):
	if !id:
		UtilsSingleton.log_error(self, "load_quest_data", "Error while loading the quest data: no quest_id was provided.")
	else:
		quest_id = id
		quest_title = StaticDataSingleton.all_quests_data[id].title
		quest_description = StaticDataSingleton.all_quests_data[id].description
		quest_steps = StaticDataSingleton.all_quests_data[id].steps
		quest_results = StaticDataSingleton.all_quests_data[id].results
		for step in quest_steps:
			var new_step_data = QuestStepComponent.new()
			new_step_data.id = step["id"]
			new_step_data.description = step["description"]
			for objective in step["objectives"]:
				var new_objective_data = QuestObjectiveComponent.new()
				new_objective_data.id = objective["id"]
				new_objective_data.title = objective["title"]
				new_objective_data.description = objective["description"]
				new_objective_data.goal = objective["goal"]
				for char in objective["characters"]:
					new_objective_data.characters.append(char)
				for res in objective["results"]:
					new_objective_data.results.append(res)
				new_objective_data.mandatory = objective["mandatory"]
				new_objective_data.success = objective["success"]
				new_step_data.objectives.append(new_objective_data)
			new_step_data.active = step["active"]
			quest_steps.append(new_step_data)
		for res in quest_results:
			quest_results.append(res)
	UtilsSingleton.log_data(self, "load_quest_data", quest_title)
	return self
	
