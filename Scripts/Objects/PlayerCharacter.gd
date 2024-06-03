class_name PlayerCharacter
extends CharacterBody2D

var current_game_state : String

func _ready():
	SignalBusSingleton.newstate.connect(set_current_state)

func _physics_process(delta):
	#Pause
	#TODO create pause menu
	#$InputComponent.check_pause_button()
	
	#Journal
	#TODO create journal menu
	#$InputComponent.check_journal_button()
	
	#Movement
	if current_game_state == "moving":
		InputManager.check_directions_buttons($MovementComponent.move)
		InputManager.check_run_button($MovementComponent.run)
		InputManager.check_jump_button($MovementComponent.jump)
	
	#Interaction
	if current_game_state == "interacting":
		InputManager.check_interact_button($"Interaction Nodes/InteractionComponent".interact)

func set_current_state(previous_state : String, new_state : String):
	current_game_state = new_state
	pass
