class_name InventoryManager
extends Node

@export var radial_menu : RadialMenuComponent
@export var player_character : PlayerCharacter
var current_game_state_name : String
var pickables : Array[Dictionary]
var observables : Array[Dictionary]
signal picked_up(interactable_id : String)

func _ready():
	SignalBusSingleton.newstate.connect(_on_newstate)
	SignalBusSingleton.interacted.connect(_on_interacted)
	SignalBusSingleton.radial_button_pressed.connect(_on_button_pressed)
	

#region Methods
func is_in_inventory(interactable_object : Dictionary, interaction_type : String) -> bool:
	match interaction_type:
			"obs":
				for item in observables:
					if item["interactable_id"] == interactable_object["interactable_id"]:
						return true
			"pic":
				for item in pickables:
					if item["interactable_id"] == interactable_object["interactable_id"]:
						return true
	return false
#endregion

#region Signals Callback Functions
func _on_newstate(emitter : Node, previous_state : String, new_state : String) -> void:
	if emitter.name.to_lower() == "gamestatemachine":
		match new_state:
			"moving":
				#TODO
				#1 - Radial menu invisible
				radial_menu.hide()
				radial_menu.unload_buttons()
				pass
			"selectingpickable":
				radial_menu.global_position = player_character.global_position + AppSettingsSingleton.radial_menu_offset
				radial_menu.load_pickables(pickables)
				radial_menu.show()
			_:
				return

func _on_interacted(emitter : Node, interactable : Interactable, interaction_type : String, player_position : Vector2) -> void:
	if !(interaction_type == "obs" or interaction_type == "pic"):
		return
	else:
		var interactable_object = {
			"interactable_id": interactable.interactable_id,
			"interactable_type": interactable.interactable_type,
			"interactable_label": interactable.interact_label,
			"interactable_data": {
				"name": interactable.interactable_data.interactable_name,
				"label": interactable.interactable_data.interactable_label,
				"starting_room_id": interactable.interactable_data.interactable_starting_room_id,
				"description": interactable.interactable_data.interactable_description,
				"sprite_id": interactable.interactable_data.interactable_sprite_id,
				"sprites": interactable.interactable_data.interactable_sprites.duplicate(), 
				"portraits": interactable.interactable_data.interactable_portraits.duplicate()
			}
		}
		if !is_in_inventory(interactable_object, interaction_type):
			match interaction_type:
				"obs":
					observables.append(interactable_object)
				"pic":
					pickables.append(interactable_object)
					interactable.queue_free()


func _on_button_pressed(emitter : Button) -> void:
	pass
#endregion
