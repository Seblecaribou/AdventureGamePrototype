#TeleportDictionarySingleton.gd
extends Node

#HOTEL
#Corridor
var hotel_corridor_01 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1.10,1.10),
	zoom_delay = .15
	}

#Room100
var room_100_01 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1,1),
	zoom_delay = .15
	}

var room_100_02 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1.10,1.10),
	zoom_delay = .15
	}

#Reception
var reception_01 : Dictionary = {
	collision_mask = 3,
	zoom_mutiplier = Vector2(1,1),
	zoom_delay = .25
	}

var reception_02 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1,1),
	zoom_delay = .25
	}


#STREET
var street_01 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(0.8,0.8),
	zoom_delay = .5
	}
