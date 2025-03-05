#TeleportDictionarySingleton.gd
extends Node

#HOTEL
#Corridor
var hotel_corridor_01 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1.38,1.38),
	zoom_delay = .15
	}
	
var hotel_corridor_02 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1.38,1.38),
	zoom_delay = .15
	}

#Room100
var room_100_01 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier =  Vector2(1.38,1.38),
	zoom_delay = .15
	}

var room_100_02 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier =  Vector2(1.38,1.38),
	zoom_delay = .15
	}
	
var balcony_100 : Dictionary = {
	collision_mask = 3,
	zoom_mutiplier = Vector2(1.15,1.15),
	zoom_delay = .25
	}
	
#Room101
var room_101_01 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1.38,1.38),
	zoom_delay = .15
	}

var room_101_02 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1.38,1.38),
	zoom_delay = .15
	}
	
var balcony_101 : Dictionary = {
	collision_mask = 3,
	zoom_mutiplier = Vector2(1.30,1.30),
	zoom_delay = .25
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
	zoom_mutiplier = Vector2(1,1),
	zoom_delay = .5
	}
