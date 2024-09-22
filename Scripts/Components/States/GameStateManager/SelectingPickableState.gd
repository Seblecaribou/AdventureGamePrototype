class_name SelectingPickable
extends StateComponent

func _process(delta: float) -> void:
	if %GameStateMachine.current_state.name.to_lower() != "selectingpickable":
		return
	if Input.is_action_just_released("inventory"):
		SignalBusSingleton.newstate_query.emit(self, "gamestatemachine", "moving")
