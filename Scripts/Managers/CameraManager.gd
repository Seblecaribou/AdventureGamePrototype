class_name CameraManager
extends Camera2D

var current_room : RoomComponent

func _ready() -> void:
	SignalBusSingleton.teleported.connect(_on_teleported)
	SignalBusSingleton.room_changed.connect(_on_room_changed)
	self.global_position.y += AppSettingsSingleton.camera_y_offset
	self.global_position.y = %PlayerCharacter.global_position.y

func _physics_process(delta: float) -> void:
	self.global_position.x = %PlayerCharacter.global_position.x

func _on_teleported(emitter : Node, arrival_area : String, arrival_area_data : Dictionary) -> void:
	zoom(arrival_area_data.zoom_mutiplier, arrival_area_data.zoom_delay)
	self.global_position.y = arrival_area_data.arrival_area.y

func _on_room_changed(emitter : Node, top_limit : float, left_limit : float, bottom_limit : float, right_limit : float) -> void:
	self.limit_top = top_limit
	self.limit_left = left_limit
	self.limit_bottom = bottom_limit
	self.limit_right = right_limit

func zoom(multiplier : Vector2, delay : float) -> void:
	print(multiplier, delay)
	var zoom_tween = get_tree().create_tween()
	zoom_tween.tween_method(set_zoom, zoom, multiplier, delay)
