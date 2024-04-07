class_name AnimationComponent
extends Node

@export var character : CharacterBody2D
@export var animated_sprite_2D : AnimatedSprite2D
var animation_state : String = "idle"

func _physics_process(delta):
	flip_sprite()
	
##Takes an animation state (string) and plays the corresponding animation
func animate(state : String):
	match state:
		"idle":
			animated_sprite_2D.animation = "idle"
		"jump":
			animated_sprite_2D.play("jump")
		"run":
			animated_sprite_2D.play("run")
		"observe":
			animated_sprite_2D.play("observe")

##Changes flip_h depending on the character's velocity.x
func flip_sprite() -> void:
	animated_sprite_2D.flip_h = character.velocity.x < 0

##Connects to the signal newstate from the PlayerCharacter, and stores the new_state of the character
func _on_player_state_machine_newstate(previous_state, new_state):
	animation_state = new_state
