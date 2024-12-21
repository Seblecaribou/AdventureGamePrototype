class_name Interactable
extends Area2D

@export var layer : int = 2
var interactable_id : String
var interactable_data : InteractableData
var interactable_type : String
var interact_label : String

func _ready():
	self.set_collision_layer_value(layer, true)
	interactable_id = self.get_name().to_lower()
	interactable_data = get_node("./InteractableData")
	if interactable_data != null:
		configure_interactable()


func configure_interactable():
	interactable_type = interactable_id.get_slice("_", 0)
	interactable_data.load_interactable_data(interactable_id, interactable_type)
	match interactable_type:
		"obs":
			interact_label = "Examine"
		"pic":
			interact_label = "Pick up"
		"act":
			interact_label = "Switch on"
		"char":
			interact_label = "Talk to"
