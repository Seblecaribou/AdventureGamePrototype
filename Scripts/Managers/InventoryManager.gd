class_name InventoryManager
extends Node

var pickables : Array[Interactable]
var observables : Array[Interactable]

func _ready():
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
