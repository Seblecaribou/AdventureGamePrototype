extends StateMachineComponent

@export var player_character : PlayerCharacter

func transition_state():
	if abs(player_character.velocity.x) < 1 and player_character.is_on_floor():
		current_state.transitioned.emit(current_state, "idle")
	elif abs(player_character.velocity.x) > 1 && player_character.is_on_floor():
		current_state.transitioned.emit(current_state, "run")
	elif not player_character.is_on_floor():
		current_state.transitioned.emit(current_state, "jump")
