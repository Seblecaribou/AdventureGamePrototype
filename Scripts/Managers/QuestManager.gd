class_name QuestManager
extends Node

var active_quests : Array[QuestData]
var finished_quests : Array[QuestData]

func _ready():
	pass
	
func load_quests():
	print("Active quests: ")
	print("FinishedQuests: ")
	pass

func save_quests(quests : Array[QuestData]) -> void:
	for quest in quests:
		var quest_resource : QuestData
		quest_resource = quest
	pass
