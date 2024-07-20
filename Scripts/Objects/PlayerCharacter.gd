class_name PlayerCharacter
extends CharacterBody2D

var current_game_state : String

func _ready():
	SignalBusSingleton.newstate.connect(_on_new_game_state)
	InputManager.pressed_interact.connect(_on_pressed_interact)
	InputManager.pressed_return.connect(_on_pressed_return)
	InputManager.pressed_pause.connect(_on_pressed_pause)
	InputManager.pressed_journal.connect(_on_pressed_journal)
	

func _physics_process(delta):
	if current_game_state == "moving":
		#Movement
		InputManager.check_directions_buttons($MovementComponent.move)
		InputManager.check_run_button($MovementComponent.run)
		InputManager.check_jump_button($MovementComponent.jump)
	
		#Interaction
		InputManager.check_interact_button($"Interaction Nodes/InteractionComponent".interact)
		
		#Journal
		#TODO create journal menu
		#$InputComponent.check_journal_button()
		
		#Pause
		#TODO create pause menu
		#$InputComponent.check_pause_button()


func _on_new_game_state(emitter : Node, previous_state : String, new_state : String):
	if emitter.get_name().to_lower() == 'gamestatemachine':
		current_game_state = new_state
		
func _on_pressed_interact():
	pass

func _on_pressed_pause():
	pass
	
func _on_pressed_return():
	pass

func _on_pressed_journal():
	pass
