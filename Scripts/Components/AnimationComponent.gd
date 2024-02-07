class_name AnimationComponent
extends Node

@export var state_machine : StateMachineComponent
@export var character : CharacterBody2D
@export var animated_sprite_2D : AnimatedSprite2D
var animation_state : String = "idle"

func _ready():
	pass
	#state_machine.newstate.connect(on_state_machine_newstate)

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
	
func flip_sprite() -> void:
	animated_sprite_2D.flip_h = character.velocity.x < 0
	#
#func on_state_machine_newstate(previous_state_name, new_state_name):
	#if animation_state != new_state_name:
		#animation_state = new_state_name
	#animate(animation_state)
		#
