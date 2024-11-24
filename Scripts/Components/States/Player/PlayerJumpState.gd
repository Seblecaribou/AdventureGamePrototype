class_name Jump
extends StateComponent

func enter() -> void:
	%AnimationComponent.animate("jump_start")
	await get_tree().create_timer(0.5).timeout


func exit() -> void:
	%AnimationComponent.animate("jump_end")
	await get_tree().create_timer(0.5).timeout
