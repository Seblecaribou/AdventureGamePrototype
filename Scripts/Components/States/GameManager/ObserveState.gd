class_name GameObserveState
extends StateComponent

func physics_update(delta):
	animation_component.animate("observe")
