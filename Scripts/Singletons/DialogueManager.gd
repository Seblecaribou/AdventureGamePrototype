class_name DialogueManager
extends Node

@export var dialogue_data : DialogueData
@export var dialogue_component : DialogueComponent
var current_quests_steps : Array[String]
var current_dialogue : String
var current_character : Interactable


func _ready():
	#TODO get the current quest step from the quest manager signal
	if dialogue_data != null:
		configure_dialogue()


func _on_player_character():
	#TODO create a signal that can be listened to and that changes the content of current_quests_steps
	pass

func display_dialogue() -> void:
	#TODO make dialogue appear in DialogueFrame if Interaction calls for it
	# 1 - Put text from current_dialogue into dialogue_component.dialogue_text
	pass

func load_dialogue() -> void:
	#TODO loads dialogue based of current_quests_steps and current_character
	pass

func configure_dialogue():
	#TODO loads dialogue based of current_quests_steps and current_character
	pass
