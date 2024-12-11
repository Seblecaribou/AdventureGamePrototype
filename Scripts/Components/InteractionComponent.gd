class_name InteractionComponent
extends Node

@onready var interactions: Array[Interactable]= []
@export var player_character : PlayerCharacter
@export var label: Label
@export var interaction_content : RichTextLabel
signal in_transition_area(emitter : Node, inside : bool)

func _ready():
	update_interact_label()
	reset_interaction_ui()
	
func _physics_process(delta):
	reset_interaction_ui()

func _on_interaction_area_area_entered(area):
	if area.name.contains("Entrance"):
		in_transition_area.emit(self, true)
		return
	interactions.insert(0, area)
	update_interact_label()

func _on_interaction_area_area_exited(area):
	if area.name.contains("Entrance"):
		in_transition_area.emit(self, false)
		return
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

##Generates a goal_id to search in current objectives, based of interactable type, id and item being used
func generate_goal_id(interaction_type : String, interaction_id : String, item_used : String = "") -> String:
	print(item_used)
	var action_type : String
	match interaction_type:
			"obs":
				action_type = "exa"
			"pic":
				action_type = "fin"
			"act":
				action_type = "act"
			"char":
				action_type = "tal"
	var goal_id = action_type + "_" + interaction_id
	if item_used != "":
		goal_id += "_" + item_used
	return goal_id


func interact(held_item : String):
	if interactions :
		#We empty the label that serves to prompt the interaction
		label.text = ""
		var current_interaction = interactions[0]
		var current_interaction_type : String = current_interaction.interactable_type
		var goal_id = generate_goal_id(current_interaction_type, current_interaction.interactable_id, held_item)
		SignalBusSingleton.interacted.emit(self, current_interaction, current_interaction_type, player_character.global_position, goal_id)
		match current_interaction_type:
			"obs":
				SignalBusSingleton.newstate_query.emit(self, "gamestatemachine", "examining")
				interaction_content.clear()
				interaction_content.text = current_interaction.interactable_data.interactable_description
				#DEBUG
				print(current_interaction.interactable_data.interactable_description)
			"pic":
				#DEBUG
				print(current_interaction.interactable_data.interactable_description)
			"act":
				SignalBusSingleton.newstate_query.emit(self, "gamestatemachine", "activating")
				#DEBUG
				print(current_interaction.interactable_data.interactable_description)				
			"char":
				SignalBusSingleton.newstate_query.emit(self, "gamestatemachine", "selectingdialogue")
				#DEBUG
				print(current_interaction.interactable_data.interactable_label, " : ", current_interaction.interactable_data.interactable_description)
