class_name DialogueManager
extends Node

@export var quest_manager : QuestManager
@export var dialogue_data : DialogueData
@export var dialogue_component : DialogueComponent
var current_quests_steps : Array[String]
var current_dialogue : String
var current_character : Interactable


func _ready():
	SignalBusSingleton.interacted.connect(on_player_character_interacted)
	SignalBusSingleton.update_all_quests.connect(on_update_all_quests)
	#TODO get the current quest step from the quest manager signal
	

func display_dialogue() -> void:
	#TODO make dialogue appear in DialogueFrame if Interaction calls it
	dialogue_component.type_dialogue(current_dialogue)
	
func hide_dialogue() -> void:
	dialogue_component.visible = false

func load_dialogue() -> void:
	#TODO loads dialogue based of current_quests_steps and current_character
	pass

func configure_dialogue():
	#TODO loads dialogues based of current_quests_steps and current_character
	pass

#TODO create a signal that can be listened to and that changes the content of current_quests_steps
func on_player_character_interacted(emitter : Node, interactable : Interactable, interaction_type : String):
	if interaction_type == "char":
		current_character = interactable
		print("DialogueManager : ", current_character)
	if dialogue_data != null:
		configure_dialogue()
	#dialogue_component.display_dialogue()
	pass

func on_update_all_quests(emitter : Node, active_quests : Array[QuestData], FinishedQuests : Array[QuestData]):
	#TODO implement recuperation of data active/finished quest
	pass
