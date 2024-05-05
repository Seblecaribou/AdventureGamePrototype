class_name QuestManager
extends Node

var active_quests : Array[QuestResource]
var finished_quests : Array[QuestResource]

func _ready():
	pass
	
func load_quests():
	print("Active quests: ")
	print("FinishedQuests: ")
	pass

func save_quests(quests : Array[QuestResource]) -> void:
	for quest in quests:
		var quest_resource : QuestResource
		quest_resource = quest
	pass
