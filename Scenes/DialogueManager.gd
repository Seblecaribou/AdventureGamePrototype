class_name DialogueManager
extends Node

var current_quests_steps : Array[String]
var current_character : Interactable

func _ready():
	#TODO get the current quest step from the quest manager signal
	pass

func _on_quest_manager_queststate():
	#TODO create a signal that can be listened and that changes the content of current_quests_steps
	pass

func load_dialogue() -> void:
	#TODO loads dialogue based of current_quests_steps and current_character
	pass

func display_dialogue() -> void:
	#TODO make dialogue appear in DialogueFrame
	pass
