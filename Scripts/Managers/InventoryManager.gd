class_name InventoryManager
extends Node

@export var radial_menu : RadialMenuComponent
var player_position : Vector2
var pickables : Array[Interactable]
var observables : Array[Interactable]
signal picked_up(interactable_id : String)

func _ready():
	SignalBusSingleton.newstate.connect(_on_newstate)
	SignalBusSingleton.interacted.connect(_on_interacted)
	

func is_in_inventory(interactable : Interactable, interactable_type : String) -> bool:
	match interactable_type:
		"obs":
			return observables.has(interactable)
		"pic":
			return pickables.has(interactable)
	return false


#Signals Callback Functions
func _on_interacted(emitter : Node, interactable : Interactable, interaction_type : String, player_position : Vector2) -> void:
	if !(interaction_type == "obs" or interaction_type == "pic"):
		return
	else:
		if !is_in_inventory(interactable, interaction_type):
			match interaction_type:
				"obs":
					observables.append(interactable)
				"pic":
					pickables.append(interactable)
					interactable.queue_free()
	
	
func _on_newstate(emitter : Node, previous_state : String, new_state : String) -> void:
	if emitter.name.to_lower() == "gamestatemachine":
		match new_state:
			"moving":
				#TODO
				#1 - Radial menu invisible
				radial_menu.visible = false
				print("_on_newstate - radial_menu.visible : ", radial_menu.visible)
				pass
			"selectingpickable":
				radial_menu.visible = true
				print("_on_newstate - radial_menu.visible : ", radial_menu.visible)
				radial_menu.global_position = player_position + AppSettingsSingleton.radial_menu_offset
			_:
				return
	
