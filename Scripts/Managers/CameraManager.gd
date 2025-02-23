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

#region Methods
func zoom(multiplier : Vector2, delay : float) -> void:
	var zoom_tween : Tween = get_tree().create_tween()
	zoom_tween.tween_method(set_zoom, zoom, multiplier, delay)
	
func change_camera(new_x : Variant, new_y : Variant) -> void:
	var camera_movement_tween : Tween = get_tree().create_tween()
	if new_x != null:
		camera_movement_tween.tween_property(self, "global_position:x", new_x, 1)
	if new_y != null:
		camera_movement_tween.tween_property(self, "global_position:y", new_y, 1)
#region

#region Signal Callback functions
func _on_teleported(emitter : Node, player_z : int, arrival_area : String, arrival_area_data : Dictionary) -> void:
	zoom(arrival_area_data.zoom_mutiplier, arrival_area_data.zoom_delay)
	#TODO revised the camera following character
	#change_camera(null, arrival_area_data.arrival_area.y)

func _on_room_changed(emitter : Node, top_limit : float, left_limit : float, bottom_limit : float, right_limit : float) -> void:
	self.limit_top = top_limit
	self.limit_left = left_limit
	self.limit_bottom = bottom_limit
	self.limit_right = right_limit
#region
