class_name InteractableData
extends Node

var interactable_name : String
var interactable_label : String
var interactable_starting_room_id : String
var interactable_description : String
var interactable_sprite_id : String
var interactable_sprites : Array[String]
var interactable_portraits : Array[String]

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
				interactable_name = StaticDataSingleton.actionable_items[id].name
				interactable_starting_room_id = StaticDataSingleton.actionable_items[id].room_id
				interactable_description = StaticDataSingleton.actionable_items[id].description
				interactable_label = StaticDataSingleton.actionable_items[id].label
				interactable_sprite_id = StaticDataSingleton.actionable_items[id].sprite_id
			"char": 
				interactable_name = StaticDataSingleton.non_playable_characters[id].name
				interactable_starting_room_id = StaticDataSingleton.non_playable_characters[id].room_id
				interactable_description = StaticDataSingleton.non_playable_characters[id].description
				interactable_label = StaticDataSingleton.non_playable_characters[id].label
				for sprite in  StaticDataSingleton.non_playable_characters[id].sprites:
					interactable_sprites.append(sprite)
				for portrait in  StaticDataSingleton.non_playable_characters[id].portraits:
					interactable_sprites.append(portrait)
	else:
		print("Error while loading the interactable data: no interactable_id was provided.")
