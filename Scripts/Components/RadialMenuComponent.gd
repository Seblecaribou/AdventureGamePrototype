class_name RadialMenuComponent
extends Control

@export var player_character : PlayerCharacter
var nb_pickables : int

#TEST delete ones the system is in place
@export var line_color : Color
@export var inner_radius : int = 100
@export var line_width : int = 4

func _draw() -> void:
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width, true)
	

func load_pickables(pickables : Array[Interactable]) -> void:
	nb_pickables = pickables.size()
	for pickable_index in range(nb_pickables):
		var pickable : Interactable = pickables[pickable_index]
		#TODO
		#1 - Fetch the image and instanciate it
		var pickable_button :Button
		pickable_button.icon = load("res://icon.svg")
		#2 - Create a label and hide it (it will be visible when mouse hover)
		#3 - Place the pickable on a circle depending on the index of pickable in pickables
		place_pickable(pickable_button, pickable, pickable_index)
		pass

func place_pickable(pickable_button : Button, pickable : Interactable, pickable_index : int):
	var pickable_angle_to_center = 360 / nb_pickables * pickable_index
	var pickable_x = inner_radius * cos(pickable_angle_to_center) * (pickable_index +1)
	var pickable_y = inner_radius * sin(pickable_angle_to_center) * (pickable_index + 1)
	var pickable_relative_position : Vector2 = Vector2(pickable_x, pickable_y)
	pickable_button.global_position = player_character.global_position + pickable_relative_position

	pass
