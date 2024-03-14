class_name Interactable
extends Area2D

@export var item_id : String
var item_data : Node
var character_data : Node
var interact_type : String
var interact_label : String

func _ready():
	interact_type = item_id.get_slice("_", 0)
	item_data = get_node("./ItemData")
	character_data = get_node("./CharacterData")
	if item_data != null:
		configure_interactable()


func configure_interactable():
	interact_type = item_id.get_slice("_", 0)
	item_data.load_item_data(item_id, interact_type)
	match interact_type:
		"obs":
			interact_label = "Examine"
		"pic":
			interact_label = "Pick up"
		"act":
			interact_label = "Switch on"
		"npc":
			interact_label = "Talk to"
