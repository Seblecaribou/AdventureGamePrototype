class_name Item
extends Node

var item_name : String
var item_label : String
var item_room_id : String
var item_description : String
var item_sprite_id : String

func load_item_data(id : String, interactable_type: String):
	if id:
		match interactable_type:
			"obs":
				item_name = StaticDataSingleton.observable_items[id].name
				item_room_id = StaticDataSingleton.observable_items[id].room_id
				item_description = StaticDataSingleton.observable_items[id].description
				item_label = StaticDataSingleton.observable_items[id].label
				item_sprite_id = StaticDataSingleton.observable_items[id].sprite_id				
			"pic":
				item_name = StaticDataSingleton.pickable_items[id].name
				item_room_id = StaticDataSingleton.pickable_items[id].room_id				
				item_description = StaticDataSingleton.pickable_items[id].description
				item_label = StaticDataSingleton.pickable_items[id].label
				item_sprite_id = StaticDataSingleton.pickable_items[id].sprite_id
			"act":
				pass
	else:
		print("Error while loading the item data: no item_id was provided.")
	print("Item data loaded: " + id)
