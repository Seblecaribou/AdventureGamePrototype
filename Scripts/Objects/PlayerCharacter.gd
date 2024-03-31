class_name PlayerCharacter
extends CharacterBody2D

var current_game_state : String

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
		InputManager.check_interact_button($InteractionComponent.interact)


func _on_game_state_machine_newstate(previous_state, new_state):
	current_game_state = new_state

