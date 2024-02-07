class_name PlayerRunState
extends StateComponent

func physics_update(delta):
	if abs(player_character.velocity.x) > 1:
		animation_component.animate("run")
	else:
		transitioned.emit(self, "idle")
