class_name CameraManager
extends Camera2D

func _ready() -> void:
	self.global_position.y += AppSettingsSingleton.camera_y_offset

func _process(delta: float) -> void:
	self.global_position.x = %PlayerCharacter.global_position.x
