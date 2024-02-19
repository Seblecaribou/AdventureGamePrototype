class_name PlayerObserveState
extends StateComponent

func physics_process(delta):
	animation_component.animate("observe")
