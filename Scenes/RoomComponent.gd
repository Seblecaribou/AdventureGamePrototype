class_name RoomComponent
extends Control

func _ready() -> void:
	self.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	SignalBusSingleton.transitioned_area.connect(_on_transioned_area)

func _on_transioned_area(emitter: Node, is_back : bool, player_z : int, transition_area_name : String) -> void:
	print(transition_area_name)
	#We use the name of the EntranceBackground collision node to select which BackgroundTopLayer should be displayed or hidden
	var transition_area_id = str(int(transition_area_name.trim_prefix("EntranceBackground")) - 1)
	print(transition_area_id)
	var background_top_layer_node_path : String = "Background" + transition_area_id + "TopLayer"
	var background_top_layer_node :TextureRect = get_node(background_top_layer_node_path)
	if background_top_layer_node:
		if is_back:
			background_top_layer_node.z_index = player_z + 1
			background_top_layer_node.set_mouse_filter(TextureRect.MOUSE_FILTER_IGNORE)
			background_top_layer_node.show()
		else:
			background_top_layer_node.hide()
