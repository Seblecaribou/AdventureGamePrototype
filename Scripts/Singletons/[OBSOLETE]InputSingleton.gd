##InputSingleton.gd
#extends Node2D
#
#signal pressed_jump
#signal pressed_run
#signal pressed_interact
#signal pressed_return
#signal pressed_pause
#signal pressed_journal
#
#
#func _process(delta):
	#check_input()
#
#
#func check_input() -> void:
	###Jump Button
	###Connected : PlayerCharacter
	#if Input.is_action_just_pressed("jump"):
		#pressed_jump.emit()
	#
	###Run Button
	###Connected : PlayerCharacter
	#if Input.is_action_pressed("run"):
		#pressed_run.emit()
#
	###Interact Button
	###Connected : PlayerCharacter
	#if Input.is_action_just_pressed("interact"):
		#pressed_interact.emit()
#
	###Return Button
	###Connected : PlayerCharacter
	#if Input.is_action_just_pressed("return"):
		#pressed_return.emit()
		#
	###Pause Button
	###Connected : PlayerCharacter
	#if Input.is_action_just_pressed("pause"):
		#pressed_pause.emit()
		#
	###Journal Button
	###Connected : PlayerCharacter
	#if Input.is_action_just_pressed("journal"):
		#pressed_return.emit()
		#
#
#func check_jump_button(function: Callable) -> void:
	#if Input.is_action_just_pressed("jump"):
		#function.call()
#
#func check_directions_buttons(function: Callable) -> void:
	#var direction: float = Input.get_axis("left", "right")
	#function.call(direction)
#
#func check_run_button(function: Callable) -> void:
	#if Input.is_action_pressed("run"):
		#function.call(true)
	#else:
		#function.call(false)
#
#func check_interact_button(function: Callable) -> void:
	#if Input.is_action_just_pressed("interact"):
		#function.call()
#
#func check_return_button(function: Callable) -> void:
	#if Input.is_action_just_pressed("return"):
		#function.call()
#
#func check_pause_button(function: Callable) -> void:
	#if Input.is_action_just_pressed("pause"):
		#function.call()
#
#func check_journal_button(function: Callable) -> void:
	#if Input.is_action_just_pressed("journal"):
		#function.call()
