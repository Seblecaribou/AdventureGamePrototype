class_name PlayerCharacter
extends CharacterBody2D

@export var game_state_machine : StateMachineComponent
var input_manager = InputManager
var current_game_state : String

func _physics_process(delta):
	current_game_state = game_state_machine.current_state.name.to_lower()
	
	#Pause
	#TODO create pause menu
	#$InputComponent.check_pause_button()
	
	#Journal
	#TODO create journal menu
	#$InputComponent.check_journal_button()
	
	#Movement
	if current_game_state == "moving":
		input_manager.check_directions_buttons($MovementComponent.move)
		input_manager.check_run_button($MovementComponent.run)
		input_manager.check_jump_button($MovementComponent.jump)
	
	#Interaction
	#if current_game_state == "observe":
		#input_manager.check_interact_button($InteractionComponent.interact)
