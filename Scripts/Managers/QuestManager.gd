class_name QuestManager
extends Node

var active_quests : Array[QuestData]
var finished_quests : Array[QuestData]

func _ready():
	pass
	
func load_quests():
	print("Active quests: ")
	print("Finished quests: ")
	pass

func save_quests(quests : Array[QuestData]) -> void:
	for quest in quests:
		var quest_resource : QuestData
		quest_resource = quest
		if quest_resource.active:
			active_quests.append(quest_resource)
		else:
			finished_quests.append(quest_resource)
			active_quests.erase(quest_resource)
	#TODO use UtilsSingleton to save quest_resource onto a Json
