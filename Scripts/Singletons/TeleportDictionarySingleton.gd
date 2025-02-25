#TeleportDictionarySingleton.gd
extends Node

var hotel_corridor_01 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1.10,1.10),
	zoom_delay = .15
	}

var reception_01 : Dictionary = {
	collision_mask = 3,
	zoom_mutiplier = Vector2(1,1),
	zoom_delay = .25
	}
