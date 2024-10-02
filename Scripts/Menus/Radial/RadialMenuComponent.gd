class_name RadialMenuComponent
extends Control

#region Variables
var is_active : bool = false
@export var player_character : PlayerCharacter
var nb_pickables : int
var pointer_direction : Vector2
var pointer_position : Vector2
@export var inner_radius : int = 80
@export var arc_angle : int = 180
@export var button_scale : Vector2 = Vector2(0.4,0.4)
#endregion

#region Ready, Process...
func _process(delta: float) -> void:
	if is_active:
		#Find direction pointed by left Joystick
		pointer_direction = Input.get_vector("left", "right", "up", "down", 1)
		pointer_position = Vector2(pointer_direction.x * inner_radius, pointer_direction.y * inner_radius)
		print("pointer_x : ", pointer_position.x)
		print("pointer_y : ", pointer_position.y)
		if Input.is_action_just_pressed("interact"):
			for button in get_children():
				#TODO
				#if button.position roughly equals pointer_position, then return button.id aka selected item id 
				pass
			
		
#endregion


#region Methods
func load_pickables(pickables : Array[Dictionary]) -> void:
	nb_pickables = pickables.size()
	for pickable_index in range(nb_pickables):
		var label : String = pickables[pickable_index]["interactable_data"]["label"]
		var id : String = pickables[pickable_index]["interactable_id"]
		var sprite_path : String =AppSettingsSingleton.base_res_path + AppSettingsSingleton.images_folder_path + "Portraits/" + pickables[pickable_index]["interactable_data"]["sprite_id"]
		var pickable_button : RadialButtonManager = add_button(id, pickable_index, sprite_path, label, button_scale)
		place_pickable(pickable_button, pickable_index)


func add_button(pickable_id : String, button_index : int, sprite_path : String, label : String, button_size : Vector2) -> RadialButtonManager:
	var new_button_instance = preload("res://Scenes/RadialButton.tscn").instantiate()
	var button_texture = load(sprite_path)
	new_button_instance.index = button_index
	new_button_instance.item_id = pickable_id
	new_button_instance.button_sprite.texture = button_texture

	new_button_instance.button_label.text = label
	new_button_instance.button_label.visible = false
	new_button_instance.scale = button_size

	var sprite_size = new_button_instance.button_sprite.texture.get_size()
	new_button_instance.radial_button_component.size = sprite_size
	print("Button size : ", new_button_instance.radial_button_component.size)
	new_button_instance.z_index = 5
	add_child(new_button_instance)
	return new_button_instance
	
##Places the pickable in an arc around the head of the player character
func place_pickable(pickable_button : RadialButtonManager, pickable_index : int):
	var angle_step : float
	match nb_pickables:
		0:
			return
		1:
			angle_step = arc_angle
		_:
			angle_step = arc_angle / (nb_pickables - 1)
	var pickable_angle_to_first_item = angle_step * (pickable_index)
	var pickable_x = inner_radius * cos(deg_to_rad(pickable_angle_to_first_item))
	var pickable_y = inner_radius * sin(deg_to_rad(pickable_angle_to_first_item))
	pickable_button.position = Vector2(- pickable_x, - pickable_y)

##Empties the menu to stop duplication and free memory
func unload_buttons():
	for button in get_children():
		button.free()
	if self.get_child_count() > 0:
		UtilsSingleton.log_error(self, "unload_buttons", "Error while emptying radial menu: some buttons were not unloaded.")
	else:
		UtilsSingleton.log_data(self, "unload_buttons", "Radial menu is empty")
#endregion
