class_name PlayerIdleState
extends StateComponent

func physics_update(delta):
	animation_component.animate("idle")
