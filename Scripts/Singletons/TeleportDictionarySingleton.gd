#TeleportDictionarySingleton.gd
extends Node

var hotel_corridor_01 : Dictionary = {
	arrival_area = Vector2(253,-635),
	collision_mask = 2,
	player_scale = Vector2(1,1),
	zoom_mutiplier = Vector2(1.02,1.02),
	zoom_delay = .05
	}

var reception_01 : Dictionary = {
	arrival_area = Vector2(1109,40),
	collision_mask = 3,
	player_scale = Vector2(0.6,0.6),
	zoom_mutiplier = Vector2(1,1),
	zoom_delay = .05
	}
