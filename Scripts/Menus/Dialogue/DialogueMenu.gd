class_name DialogueMenu
extends Node2D


func add_button(button_index : int, objective_id : String, label : String):
	var button_scene = preload("res://Scenes/DialogueButton.tscn")
	var new_button_instance = button_scene.instantiate()
	new_button_instance.index = button_index
	new_button_instance.objective_id = objective_id
	new_button_instance.button_label.text = label
	add_child(new_button_instance)

func place_buttons():
	if get_child_count() > 0:
		for button in get_children():
			var button_y_position = AppSettingsSingleton.dialogue_button_size.y + AppSettingsSingleton.dialogue_menu_spacing
			button.position.y = button_y_position * button.index

func unload_buttons():
	for button in get_children():
		button.free()
	if self.get_child_count() > 0:
		UtilsSingleton.log_error(self, "unload_buttons", "Error while emptying menu: some buttons were not unloaded.")
	else:
		UtilsSingleton.log_data(self, "unload_buttons", "Dialogue menu is empty")
