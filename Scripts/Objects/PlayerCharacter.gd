class_name PlayerCharacter
extends CharacterBody2D

@export var interaction_component : InteractionComponent
@export var movement_component : MovementComponent
var current_game_state : String

func _ready():
	SignalBusSingleton.newstate.connect(_on_new_game_state)
	InputManager.pressed_interact.connect(_on_pressed_interact)
	InputManager.pressed_return.connect(_on_pressed_return)
	InputManager.pressed_pause.connect(_on_pressed_pause)
	InputManager.pressed_journal.connect(_on_pressed_journal)

func _physics_process(delta):
	if current_game_state == "moving":
		InputManager.check_directions_buttons($MovementComponent.move)



func _on_new_game_state(emitter : Node, previous_state : String, new_state : String):
	if emitter.get_name().to_lower() == 'gamestatemachine':
		current_game_state = new_state

func _on_pressed_run():
	if current_game_state == "moving":
		movement_component.run(true)

func _on_pressed_jump():
	if current_game_state == "moving":
		movement_component.jmup()

func _on_pressed_interact():
	if current_game_state == "moving":
		interaction_component.interact()

func _on_pressed_pause():
	#TODO Add pause menu
	pass
	
func _on_pressed_journal():
	#TODO Add journal menu
	pass

func _on_pressed_return():
	#Not in use for now
	pass
	


