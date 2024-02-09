class_name PlayerCharacter
extends CharacterBody2D

func _physics_process(delta):
	#Pause
	#TODO create pause menu
	#$InputComponent.check_pause_button()
	
	#Journal
	#TODO create journal menu
	#$InputComponent.check_journal_button()
	
	#Movement
	$InputComponent.check_directions_buttons($MovementComponent.move)
	$InputComponent.check_run_button($MovementComponent.run)
	$InputComponent.check_jump_button($MovementComponent.jump)
	
	#Interaction
	$InputComponent.check_interact_button($InteractionComponent.interact)
