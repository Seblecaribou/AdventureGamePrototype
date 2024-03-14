class_name Character
extends Node

var character_name : String
var character_label : String
var character_starting_room_id : String
var character_description : String
var character_sprite_id : String

func load_item_data(id : String):
	if id:
		pass
	else:
		print("Error while loading the character data: no character_id was provided.")
	print("Item data loaded: " + id)
