class_name DialogueMenu
extends Node2D

#region Variables
var is_active : bool = false
var button_nodes : Array[Button] = []
#endregion

#region Ready, Process...
func _process(delta: float) -> void:
	handle_gamepad_controls()
#endregion

#region Methods
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
		var max_button_index : int = buttons.size() -1
		var top_neighbor_button_path : String
		var bottom_neighbor_button_path : String
		#Finds the Button node inside each DialogueButtonManager and stores it
		for button in buttons:
			var dialogue_button : DialogueButtonManager = button as DialogueButtonManager
			var button_component : Button = dialogue_button.dialogue_button_component
			button_nodes.append(button_component)
		
		for i in buttons.size():
			match i:
				0:
					#If first button, the top neighbor is the last one
					button_nodes[i].grab_focus()
					top_neighbor_button_path = button_nodes[max_button_index].get_path()
					bottom_neighbor_button_path = button_nodes[i + 1].get_path()
				max_button_index:
					#If last button, the bottom neighbor is the first one
					top_neighbor_button_path = button_nodes[i - 1].get_path()
					bottom_neighbor_button_path = button_nodes[0].get_path()
				_:
					#If any value in between previous button is i-1, next button is i+1
					top_neighbor_button_path = button_nodes[i - 1].get_path()
					bottom_neighbor_button_path = button_nodes[i + 1].get_path()
			button_nodes[i].set_focus_neighbor(SIDE_TOP, top_neighbor_button_path)
			button_nodes[i].set_focus_neighbor(SIDE_BOTTOM, bottom_neighbor_button_path)

func unload_buttons() -> void:
	button_nodes.clear()
	for button in get_children():
		button.free()
	if self.get_child_count() > 0:
		UtilsSingleton.log_error(self, "unload_buttons", "Error while emptying menu: some buttons were not unloaded.")
	else:
		UtilsSingleton.log_data(self, "unload_buttons", "Dialogue menu is empty")
		
func handle_gamepad_controls() -> void :
	if is_active:
		if Input.is_action_just_pressed("up"):
			for i in button_nodes.size():
				if button_nodes[i].has_focus():
					button_nodes[i].focus_neighbor_top
		if Input.is_action_just_pressed("down"):
			for i in button_nodes.size():
				if button_nodes[i].has_focus():
					button_nodes[i].focus_neighbor_bottom
		if Input.is_action_just_pressed("jump"):
			for button in button_nodes:
				if button.has_focus():
					button.pressed.emit()
#endregion
