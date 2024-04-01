class_name DialogueManager
extends Node

@export var dialogue_data : DialogueData
@export var dialogue_component : DialogueComponent
@export var player_character : PlayerCharacter
var current_quests_steps : Array[String]
var current_dialogue : String
var current_character : Interactable


func _ready():
	#TODO get the current quest step from the quest manager signal
	if dialogue_data != null:
		configure_dialogue()


#TODO create a signal that can be listened to and that changes the content of current_quests_steps
func _on_player_character_interacted():
	if dialogue_data != null:
		configure_dialogue()
	dialogue_component.visible = true
	pass

func display_dialogue() -> void:
	#TODO make dialogue appear in DialogueFrame if Interaction calls it
	dialogue_component.type_dialogue(current_dialogue)
	
func hide_dialogue() -> void:
	dialogue_component.visible = false

func load_dialogue() -> void:
	#TODO loads dialogue based of current_quests_steps and current_character
	pass

func configure_dialogue():
	#TODO loads dialogue based of current_quests_steps and current_character
	pass
