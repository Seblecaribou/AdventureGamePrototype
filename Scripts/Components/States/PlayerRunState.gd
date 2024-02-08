class_name PlayerRunState
extends StateComponent

func physics_update(delta):
	animation_component.animate("run")
	
	#Transition to other states
	if not player_character.is_on_floor():
		transitioned.emit(self,"jump")
	if abs(player_character.velocity.x) < 1:
		transitioned.emit(self, "idle")
