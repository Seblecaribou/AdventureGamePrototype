class_name InteractableData
extends Node

var interactable_name : String
var interactable_label : String
var interactable_starting_room_id : String
var interactable_description : String
var interactable_sprite_id : String

func load_interactable_data(id : String, interactable_type : String):
	if id:
		match interactable_type:
			"obs":
				interactable_name = StaticDataSingleton.observable_items[id].name
				interactable_starting_room_id = StaticDataSingleton.observable_items[id].room_id
				interactable_description = StaticDataSingleton.observable_items[id].description
				interactable_label = StaticDataSingleton.observable_items[id].label
				interactable_sprite_id = StaticDataSingleton.observable_items[id].sprite_id				
			"pic":
				interactable_name = StaticDataSingleton.pickable_items[id].name
				interactable_starting_room_id = StaticDataSingleton.pickable_items[id].room_id				
				interactable_description = StaticDataSingleton.pickable_items[id].description
				interactable_label = StaticDataSingleton.pickable_items[id].label
				interactable_sprite_id = StaticDataSingleton.pickable_items[id].sprite_id
			"act":
				pass
			"char":
				pass
	else:
		print("Error while loading the interactable data: no interactable_id was provided.")
	print("Interactable data loaded: " + id)
