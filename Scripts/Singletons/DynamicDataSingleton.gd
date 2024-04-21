extends Node

var save_path : String

func load_quests() -> void:
	if ResourceSaver.exists(save_path):
		
		pass

func save_quests(quests : Array[QuestResource]) -> void:
	for quest in quests:
		var quest_resource : QuestResource
		quest_resource = quest
		ResourceSaver.save(quest_resource, save_path)
		pass
	pass
