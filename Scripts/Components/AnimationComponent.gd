class_name AnimationComponent
extends Node

@export var character : CharacterBody2D
@export var animated_sprite_2D : AnimatedSprite2D
var animation_state : String = "idle"

func _physics_process(delta):
	flip_sprite()
	

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
	
func flip_sprite() -> void:
	animated_sprite_2D.flip_h = character.velocity.x < 0


func _on_player_state_machine_newstate(previous_state, new_state):
	animation_state = new_state
