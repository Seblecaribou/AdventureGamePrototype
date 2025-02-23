class_name RoomComponent
extends Control

func _ready() -> void:
	self.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	SignalBusSingleton.transitioned_area.connect(_on_transioned_area)
	SignalBusSingleton.teleported.connect(_on_teleported)
	
	
#region Methods
func manage_layers(player_layer : int, player_z : int, is_back : bool) -> void:
	var background_top_layer_node_path : String = "Background" + str(player_layer) + "TopLayer"
	var background_top_layer_node :TextureRect = get_node(background_top_layer_node_path)
	if background_top_layer_node:
		if is_back:
			background_top_layer_node.z_index = player_z + 1
			background_top_layer_node.set_mouse_filter(TextureRect.MOUSE_FILTER_IGNORE)
			background_top_layer_node.show()
		else:
			background_top_layer_node.hide()
#region
	
	
#region Signal Callback functions
func _on_transioned_area(emitter: Node, is_back : bool, player_z : int, transition_area_name : String) -> void:
	#We use the name of the EntranceBackground collision node to select which BackgroundTopLayer should be displayed or hidden
	var transition_area_id : int = int(transition_area_name.trim_prefix("EntranceBackground")) - 1
	manage_layers(transition_area_id, player_z, is_back)

func _on_teleported(emitter : Node, player_z : int, arrival_area : String, arrival_area_data : Dictionary) -> void:
	#We reset the visibility of the backgrounds that are not the main one.
	manage_layers(arrival_area_data.collision_mask - 1, player_z, false)
#region
