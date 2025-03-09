#TeleportDictionarySingleton.gd
extends Node

#region HOTEL
#CORRIDOR
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

#ROOM100
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
	
#ROOM101
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

#RECEPTION
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
	
var reception_03 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1,1),
	zoom_delay = .25
	}
	
#BASEMENT
var basement : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1,1),
	zoom_delay = .25
	}
#endregion


#region STREET
var street_01 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1,1),
	zoom_delay = .5
	}

var street_02 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1,1),
	zoom_delay = .5
	}
#endregion


#region SEWERS
var sewers_01 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1,1),
	zoom_delay = .5
	}
	
var sewers_02 : Dictionary = {
	collision_mask = 2,
	zoom_mutiplier = Vector2(1,1),
	zoom_delay = .5
	}
#endregion

#region BAKERY
#Bakery

#Kitchen

#endregion
