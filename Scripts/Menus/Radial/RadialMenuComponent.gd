class_name RadialMenuComponent
extends Control

@export var player_character : PlayerCharacter
var nb_pickables : int

@export var inner_radius : int = 80
@export var arc_radius : int = 360
@export var button_size : Vector2 = Vector2(0.4,0.4)

func load_pickables(pickables : Array[Dictionary]) -> void:
	nb_pickables = pickables.size()
	for pickable_index in range(nb_pickables):
		var pickable_button : Button = Button.new()
		var label : String = pickables[pickable_index]["interactable_data"]["label"]
		pickable_button.text = label
		#TEST
		pickable_button.text = ""
		var icon : Texture2D = load("res://Images/Portraits/char_chiro_happy.png")
		pickable_button.icon = icon
		pickable_button.scale = button_size
		pickable_button.z_index = 5
		add_child(pickable_button)
		place_pickable(pickable_button, pickable_index)
		#2 - Create a label and hide it (it will be visible when mouse hover)
		#3 - Place the pickable on a circle depending on the index of pickable in pickables

##Places the pickable in an arc around the head of the player character
func place_pickable(pickable_button : Button, pickable_index : int):
	#Determines the angle between last button and current one, depending on number of item in inventory
	var angle_step = arc_radius / nb_pickables
	var pickable_angle_to_center = angle_step * (pickable_index + 1)
	#Determines the Vector2 for the item position
	var pickable_x = inner_radius * cos(deg_to_rad(pickable_angle_to_center)) * (pickable_index +1)
	var pickable_y = inner_radius * sin(deg_to_rad(pickable_angle_to_center)) * (pickable_index + 1)
	#Places the item
	pickable_button.position = Vector2(pickable_x, pickable_y)
	
	
func unload_buttons():
	for button in get_children():
		button.free()
	if self.get_child_count() > 0:
		UtilsSingleton.log_error(self, "unload_buttons", "Error while emptying radial menu: some buttons were not unloaded.")
	else:
		UtilsSingleton.log_data(self, "unload_buttons", "Radial menu is empty")
