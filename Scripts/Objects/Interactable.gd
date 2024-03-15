class_name Interactable
extends Area2D

@export var interactable_id : String
var iteractable_data : Node
var interactable_type : String
var interact_label : String

func _ready():
	iteractable_data = get_node("./ItemData")
	if iteractable_data != null:
		configure_interactable()


func configure_interactable():
	interactable_type = interactable_id.get_slice("_", 0)
	iteractable_data.load_interactable_data(interactable_id, interactable_type)
	match interactable_type:
		"obs":
			interact_label = "Examine"
		"pic":
			interact_label = "Pick up"
		"act":
			interact_label = "Switch on"
		"npc":
			interact_label = "Talk to"
