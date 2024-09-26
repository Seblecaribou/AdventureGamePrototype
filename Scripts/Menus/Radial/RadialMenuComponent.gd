class_name RadialMenuComponent
extends Control

@export var player_character : PlayerCharacter
var nb_pickables : int

@export var inner_radius : int = 80
@export var arc_angle : int = 180
@export var button_size : Vector2 = Vector2(0.4,0.4)

func load_pickables(pickables : Array[Dictionary]) -> void:
	nb_pickables = pickables.size()
	for pickable_index in range(nb_pickables):
		var pickable_button : Button = Button.new()
		var label : String = pickables[pickable_index]["interactable_data"]["label"]
		pickable_button.text = label
		pickable_button.text = "" #TEST
		var sprite_path : String =AppSettingsSingleton.base_res_path + AppSettingsSingleton.images_folder_path + "Portraits/" + pickables[pickable_index]["interactable_data"]["sprite_id"]
		var icon : Texture2D = load(sprite_path)
		pickable_button.icon = icon
		pickable_button.scale = button_size
		pickable_button.z_index = 5
		add_child(pickable_button)
		place_pickable(pickable_button, pickable_index)

##Places the pickable in an arc around the head of the player character
func place_pickable(pickable_button : Button, pickable_index : int):
	#Determines the angle between last button and current one, depending on number of item in inventory
	#Because we don't use full circle, we divide by nb_pickables - 1
	var angle_step = arc_angle / (nb_pickables - 1)
	var pickable_angle_to_first_item = angle_step * (pickable_index)
	#Determines the Vector2 for the item position
	var pickable_x = inner_radius * cos(deg_to_rad(pickable_angle_to_first_item))
	var pickable_y = inner_radius * sin(deg_to_rad(pickable_angle_to_first_item))
	#Places the item starting on the left of center
	pickable_button.position = Vector2(- pickable_x, - pickable_y)
	
	
func unload_buttons():
	for button in get_children():
		button.free()
	if self.get_child_count() > 0:
		UtilsSingleton.log_error(self, "unload_buttons", "Error while emptying radial menu: some buttons were not unloaded.")
	else:
		UtilsSingleton.log_data(self, "unload_buttons", "Radial menu is empty")
