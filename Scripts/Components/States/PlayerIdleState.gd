class_name PlayerIdleState
extends StateComponent

func physics_update(delta):
	if (player_character.velocity.x > 1 || player_character.velocity.x < -1):
		transitioned.emit(self, "run")
	else:
		animation_component.animate("idle")
	if not player_character.is_on_floor():
		transitioned.emit(self, "jump")
