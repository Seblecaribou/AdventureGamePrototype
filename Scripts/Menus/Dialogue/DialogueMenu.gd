class_name DialogueMenu
extends Node

var dialogue_menu_position : Vector2



func add_button(button_index : int, objective_id : String, label : String):
	var button_scene = preload("res://Scenes/DialogueButtonComponent.tscn")
	var new_button_instance = button_scene.instantiate()
	new_button_instance.index = button_index
	new_button_instance.objective_id = objective_id
	new_button_instance.text = label


	

