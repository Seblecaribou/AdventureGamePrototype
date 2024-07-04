class_name DialogueMenu
extends Node

func add_button(objective_id : String, label : String):
	var button_scene = preload("res://Scenes/DialogueButtonComponent.tscn")
	var new_button_instance = button_scene.instantiate()
	new_button_instance.objective_id = objective_id
	new_button_instance.text = label
	self.add_child(new_button_instance)
	
	# Ensure button is visible
	new_button_instance.show()
	
	# Log for debugging
	print("Button added with label: " + label + " and objective_id: " + objective_id)
	print("Total children in DialogueMenu: " + str(get_child_count()))
	
	# Ensure the scene tree updates
	call_deferred("_update_scene_tree")

func _update_scene_tree():
	# Dummy function to force scene tree update if needed
	pass
