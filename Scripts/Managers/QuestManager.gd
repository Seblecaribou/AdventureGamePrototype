class_name QuestManager
extends Node

var active_quests : Array[QuestData]
var finished_quests : Array[QuestData]

func _ready():
	pass
	
func load_quests():
	var file_path : String = "user://" + DynamicDataSingleton.quest_file_name + ".json"
	var default_file_path : String = "user://" + "default_" + DynamicDataSingleton.quest_file_name + ".json"
	var quest_dictionary : Dictionary
	quest_dictionary = UtilsSingleton.load_json_file(file_path)
	if quest_dictionary.size() == 0:
		quest_dictionary = UtilsSingleton.load_json_file(default_file_path)
	active_quests = quest_dictionary["active_quests"]
	finished_quests = quest_dictionary["finished_quests"]
	SignalBusSingleton.update_all_quests.emit(self, active_quests, finished_quests)


func save_quests(quests : Array[QuestData]) -> void:
	for quest in quests:
		if quest.active:
			active_quests.append(quest)
		else:
			finished_quests.append(quest)
			active_quests.erase(quest)
	var quest_dictionary : Dictionary = { "active_quests" : active_quests, "finished_quests" : finished_quests }
	UtilsSingleton.save_json_file(DynamicDataSingleton.quest_file_name, quest_dictionary)
