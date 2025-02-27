class_name InteractionComponent
extends Node

@onready var interactions: Array[Interactable]= []
@export var player_character : PlayerCharacter
@export var label: Label
@export var interaction_content : RichTextLabel
#Connected : PlayerCharacter
signal in_transition_area(emitter : Node, inside : bool, entrance_name : String)

func _ready():
	update_interact_label()
	reset_interaction_ui()
	
func _physics_process(delta):
	reset_interaction_ui()


#region Methods
func update_interact_label():
	if interactions:
		label.text = interactions[0].interact_label
	else:
		label.text = ""

func reset_interaction_ui():
	if player_character.current_game_state == "moving":
		interaction_content.text = ""


##Generates a goal_id to search in current objectives, based of interactable type, id and item being used
func generate_goal_id(interaction_type : String, interaction_id : String, item_used : String = "") -> String:
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

func get_room_boundaries(area: Area2D, default : bool) -> Dictionary:
	#We can set up the camera boundaries at unlimited in case there is an issue with the RoomBoundary component
	if default:
		return { "top": -10000000, "left":  -10000000,  "bottom":  10000000, "right":  10000000 }
		
	# Recup the CollisionShape2D that represents the boundaries
	var collision_boundary = area.get_node("CollisionShape2D")
	if !collision_boundary or !collision_boundary.shape is RectangleShape2D:
		UtilsSingleton.log_error(self, "get_area2d_bounds", "RoomBoundary was not set properly")
		return {}

	#We calculate x and y values for top, left, bottom and right based of the center of the area
	var half_width = collision_boundary.shape.size.x * 0.5 * area.scale.x
	var half_height = collision_boundary.shape.size.y * 0.5 * area.scale.y
	var global_pos = area.global_position

	var top = global_pos.y 
	var left = global_pos.x 
	var bottom = global_pos.y + half_height
	var right = global_pos.x + collision_boundary.shape.size.x

	return { "top": top, "left": left,  "bottom": bottom, "right": right }
	
func get_teleport_arrival_area_node(area_name : String) -> CollisionShape2D:
	var arrival_area_name : String = "ar_" + area_name
	var teleport_arrival_nodes = get_tree().get_nodes_in_group("ArrivalTeleport")
	for node in teleport_arrival_nodes:
		if node.name == arrival_area_name:
			return node.get_child(0)
	UtilsSingleton.log_error(self, "get_teleport_arrival_area_node", "No node with the arrival name " + arrival_area_name)
	return null

##Handles player character's interaction with objects and NPCs
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
#region

#region Signal Callback functions
func _on_interaction_area_area_entered(area):
	# ENTRANCE BACKGROUND
	if area.is_in_group("EntranceBackground"):
		in_transition_area.emit(self, true, area.name)
		return
	
	# TELEPORT
	if area.is_in_group("EntranceTeleport"):
		SignalBusSingleton.in_teleport_entrance.emit(self, area)
		return
	
	# ROOM BOUNDARIES
	if area.is_in_group("RoomBoundary"):
		var room_boundaries : Dictionary = get_room_boundaries(area, false)
		if room_boundaries.is_empty():
			UtilsSingleton.log_error(self, "_on_interaction_area_area_entered (RoomBoundary)", "Room boundaries were not loaded; default to unlimited camera.")
			room_boundaries = get_room_boundaries(area, true)
		SignalBusSingleton.room_changed.emit(self, room_boundaries.top, room_boundaries.left, room_boundaries.bottom, room_boundaries.right)
		return
		
	interactions.insert(0, area)
	update_interact_label()

func _on_interaction_area_area_exited(area):
	if area.name.contains("Entrance"):
		in_transition_area.emit(self, false, area.name)
		return
	if area.is_in_group("EntranceTeleport"):
		SignalBusSingleton.in_teleport_entrance.emit(self, null)
		return
	interactions.erase(area)
	update_interact_label()
#region
