class_name Interactable
extends Area2D

var interactable_id : String
var iteractable_data : Node
var interactable_type : String
var interact_label : String

func _ready():
	interactable_id = self.get_name().to_lower()
	iteractable_data = get_node("./InteractableData")
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
		"char":
			interact_label = "Talk to"
