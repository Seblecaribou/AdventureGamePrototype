class_name PlayerRunState
extends StateComponent

func physics_update(delta):
	animation_component.animate("run")
