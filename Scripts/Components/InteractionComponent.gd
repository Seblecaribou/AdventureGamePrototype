class_name InteractionComponent
extends Node

@onready var interactions: Array[Interactable]= []
@export var label: Label
@export var interaction_content : RichTextLabel

func _ready():
	update_interact_label()

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

func interact():
	if interactions:
		var current_interaction = interactions[0]
		match current_interaction.interact_type:#TODO write function for each match case in INTERACT_TYPE_ENUM
			"obs":
				interaction_content.text = current_interaction.item_data.item_description
			"pic":
				print(current_interaction.item_data.item_description)
			"act":
				print(current_interaction.item_data.item_description)				
			"npc":
				print(current_interaction.item_data.item_description)
