class_name DialogueMenu
extends Node2D


func add_button(button_index : int, objective_id : String, label : String) -> void:
	var button_scene = preload("res://Scenes/DialogueButton.tscn")
	var new_button_instance = button_scene.instantiate()
	new_button_instance.index = button_index
	new_button_instance.objective_id = objective_id
	new_button_instance.button_label.text = label
	add_child(new_button_instance)

func place_buttons() -> void:
	if get_child_count() > 0:
		for button in get_children():
			var button_y_position = AppSettingsSingleton.dialogue_button_size.y + AppSettingsSingleton.dialogue_menu_spacing
			button.position.y = button_y_position * button.index
	link_buttons()

func link_buttons() -> void:
	if get_child_count() > 0:
		var buttons : Array[Node] = get_children()
		var nb_buttons : int = buttons.size()
		for i in buttons.size():
			var dialogue_button : DialogueButtonManager = buttons[i] as DialogueButtonManager
			var button_node : Button = dialogue_button.dialogue_button_component
			buttons.append(button_node)
			#TODO Add variable with previous/next button path and fix current state
			match i:
				0:
					button_node.set_focus_neighbor(SIDE_TOP, nb_buttons)
					button_node.set_focus_neighbor(SIDE_TOP, i + 1)
				nb_buttons:
					button_node.set_focus_neighbor(SIDE_TOP, nb_buttons)
					button_node.set_focus_neighbor(SIDE_BOTTOM, 0)
				_:
					button_node.set_focus_neighbor(SIDE_TOP, i - 1)
					button_node.set_focus_neighbor(SIDE_BOTTOM, i + 1)


func unload_buttons() -> void:
	for button in get_children():
		button.free()
	if self.get_child_count() > 0:
		UtilsSingleton.log_error(self, "unload_buttons", "Error while emptying menu: some buttons were not unloaded.")
	else:
		UtilsSingleton.log_data(self, "unload_buttons", "Dialogue menu is empty")
