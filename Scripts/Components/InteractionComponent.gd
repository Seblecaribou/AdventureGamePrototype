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
	print("player.current_state", player_character.current_game_state)
	if player_character.current_game_state == "moving":
		interaction_content.text = ""
		pass


func interact():
	if interactions :
		#We empty the label that serves to prompt the interaction
		label.text = ""
		var current_interaction = interactions[0]
		match current_interaction.interactable_type:
			"obs":
				SignalBusSingleton.interacted.emit(self, current_interaction.interactable_data, "obs")
				interaction_content.clear()
				interaction_content.text = current_interaction.interactable_data.interactable_description
				#DEBUG
				print(current_interaction.interactable_data.interactable_description)
			"pic":
				#TODO
				SignalBusSingleton.interacted.emit(self, current_interaction.interactable_data, "pic")
				#DEBUG
				print(current_interaction.interactable_data.interactable_description)
			"act":
				#TODO change current_interaction.interactable_activated
				SignalBusSingleton.interacted.emit(self, current_interaction.interactable_data, "act")
				#DEBUG
				print(current_interaction.interactable_data.interactable_description)				
			"char":
				#TODO signal 
				SignalBusSingleton.interacted.emit(self, current_interaction.interactable_data, "char")
				#DEBUG
				print("char", current_interaction.interactable_data.interactable_description)

func set_current_game_state():
	pass
