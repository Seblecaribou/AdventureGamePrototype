class_name InteractionComponent
extends Node

@onready var interactions: Array[Interactable]= []
@export var player_character : PlayerCharacter
@export var label: Label
@export var interaction_content : RichTextLabel

func _ready():
	update_interact_label()
	reset_interaction_ui()
	
func _physics_process(delta):
	reset_interaction_ui()

func _on_interaction_area_area_entered(area):
	interactions.insert(0, area)
	update_interact_label()


func _on_interaction_area_area_exited(area):
	interactions.erase(area)
	update_interact_label()	

func update_interact_label():
	if interactions:
		label.text = interactions[0].interact_label
	else:
		label.text = ""

func reset_interaction_ui():
	if player_character.current_game_state == "moving":
		interaction_content.text = ""
		pass

func interact():
	if interactions :
		label.text = ""
		var current_interaction = interactions[0]
		match current_interaction.interactable_type:#TODO write function for each match case in INTERACT_TYPE_ENUM
			"obs":
				interaction_content.text = current_interaction.interactable_data.interactable_description
			"pic":
				print(current_interaction.interactable_data.interactable_description)
			"act":
				print(current_interaction.interactable_data.interactable_description)				
			"char":
				#TODO create a signal to call the DialogueManager and pass it the interactable_data/interactable_id
				print("char", current_interaction.interactable_data.interactable_description)
