class_name PlayerIdleState
extends StateComponent

func physics_update(delta):
	animation_component.animate("idle")
	
	#Transition to other states
	if abs(player_character.velocity.x) > 1 && player_character.is_on_floor():
		transitioned.emit(self, "run")
	elif not player_character.is_on_floor():
		transitioned.emit(self, "jump")
