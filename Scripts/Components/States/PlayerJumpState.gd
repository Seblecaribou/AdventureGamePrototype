class_name Jump
extends StateComponent

func physics_update(delta):
	if not player_character.is_on_floor():
		animation_component.animate("jump")
	else:
		transitioned.emit(self, "idle")
