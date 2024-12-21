class_name RoomComponent
extends Control

func _ready() -> void:
	self.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	SignalBusSingleton.transitioned_area.connect(_on_transioned_area)

func _on_transioned_area(emitter: Node, is_back : bool, player_z : int) -> void:
	if $Background1TopLayer:
		if is_back:
			$Background1TopLayer.z_index = player_z + 1
			$Background1TopLayer.set_mouse_filter(TextureRect.MOUSE_FILTER_IGNORE)
			$Background1TopLayer.show()
		else:
			$Background1TopLayer.hide()
