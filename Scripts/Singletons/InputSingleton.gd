#InputSingleton.gd
extends Node2D

func check_jump_button(function: Callable) -> void:
	if Input.is_action_just_pressed("jump"):
		function.call()

func check_directions_buttons(function: Callable) -> void:
	var direction: float = Input.get_axis("left", "right")
	function.call(direction)

func check_run_button(function: Callable) -> void:
	if Input.is_action_pressed("run"):
		function.call(true)
	else:
		function.call(false)

func check_interact_button(function: Callable) -> void:
	if Input.is_action_just_pressed("interact"):
		function.call()

func check_return_button(function: Callable) -> void:
	if Input.is_action_just_pressed("return"):
		function.call()

func check_pause_button(function: Callable) -> void:
	if Input.is_action_just_pressed("pause"):
		function.call()

func check_journal_button(function: Callable) -> void:
	if Input.is_action_just_pressed("journal"):
		function.call()
