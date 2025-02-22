class_name RoomComponent
extends Control

func _ready() -> void:
	self.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	SignalBusSingleton.transitioned_area.connect(_on_transioned_area)
	SignalBusSingleton.teleported.connect(_on_teleported)

func _on_transioned_area(emitter: Node, is_back : bool, player_z : int, transition_area_name : String) -> void:
	#We use the name of the EntranceBackground collision node to select which BackgroundTopLayer should be displayed or hidden
	var transition_area_id = str(int(transition_area_name.trim_prefix("EntranceBackground")) - 1)
	var background_top_layer_node_path : String = "Background" + transition_area_id + "TopLayer"
	var background_top_layer_node :TextureRect = get_node(background_top_layer_node_path)
	if background_top_layer_node:
		if is_back:
			background_top_layer_node.z_index = player_z + 1
			background_top_layer_node.set_mouse_filter(TextureRect.MOUSE_FILTER_IGNORE)
			background_top_layer_node.show()
		else:
			background_top_layer_node.hide()

func _on_teleported(emitter : Node, arrival_area : String, arrival_area_data : Dictionary) -> void:
	#We reset the visibility of the backgrounds that are not the main one.
	for i in range(1,3):
		var background_top_layer_node_path : String = "Background" + str(i) + "TopLayer"
		var background_top_layer_node :TextureRect = get_node(background_top_layer_node_path)
		if background_top_layer_node:
			background_top_layer_node.hide()
