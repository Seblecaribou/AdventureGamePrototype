class_name Jump
extends StateComponent

func physics_update(delta):
	animation_component.animate("jump")
	
	#Transition to other states
	if player_character.is_on_floor():
		transitioned.emit(self, "idle")
