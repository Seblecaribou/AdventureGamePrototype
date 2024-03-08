class_name GameStateMachine
extends StateMachineComponent

var menu_states : Array[String] = ["pause", "journal", "observe"]

func transition_state():
	if Input.is_action_just_pressed("pause"):
		current_state.transitioned.emit(current_state, "pause")
	if Input.is_action_just_pressed("interact"):
		current_state.transitioned.emit(current_state, "observe")
	if Input.is_action_just_pressed("journal"):
		current_state.transitioned.emit(current_state, "journal")
	#TODO: remplacer par un changement de state si on sort du menu concerné
	if  check_is_in_menu() and Input.is_action_just_pressed("return"):
		current_state.transitioned.emit(current_state, "moving")
	if not check_is_in_menu():
		current_state.transitioned.emit(current_state, "moving")
	pass

func check_is_in_menu() -> bool: 
	if menu_states.has(current_state.get_name().to_lower()):
		return true
	else : 
		return false
