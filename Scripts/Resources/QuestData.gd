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
		quest_active = StaticDataSingleton.all_quests_data[id].active
	UtilsSingleton.log_data(self, "load_quest_data", quest_title)
	return self
	
