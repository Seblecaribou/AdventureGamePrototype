class_name SelectingPickable
extends StateComponent

func _process(delta: float) -> void:
	if Input.is_action_just_released("inventory"):
		SignalBusSingleton.newstate_query.emit(self, "gamestatemachine", "moving")
