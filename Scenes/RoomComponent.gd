class_name RoomComponent
extends Control

func _ready() -> void:
	self.MouseFilter.MOUSE_FILTER_IGNORE
	SignalBusSingleton.transitioned_area.connect(_on_transioned_area)

func _on_transioned_area(emitter: Node, is_back : bool, player_z : int) -> void:
	print("Changing layer: ", is_back)
	if $BackgroundTopLayer:
		if is_back:
			$BackgroundTopLayer.z_index = player_z + 1
			$BackgroundTopLayer.show()
		else:
			$BackgroundTopLayer.hide()
