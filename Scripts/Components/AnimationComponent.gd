class_name AnimationComponent
extends Node

@export var character : CharacterBody2D
@export var animated_sprite_2D : AnimatedSprite2D
var animation_state : String = "idle"

func _ready():
	SignalBusSingleton.newstate.connect(on_newstate)

func _physics_process(delta):
	animate(animation_state)
	flip_sprite()
	
##Takes animation_state (string) and plays the corresponding animation
func animate(state : String):
	match state:
		"idle":
			animated_sprite_2D.animation = "idle"
		"jump_start":
			animated_sprite_2D.play("jump_start")
		"jump":
			animated_sprite_2D.play("jump")
		"jump_end":
			animated_sprite_2D.play("jump_end")
		"run":
			animated_sprite_2D.play("run")
		"observe":
			animated_sprite_2D.play("observe")

##Changes flip_h depending on the character's velocity.x
func flip_sprite() -> void:
	animated_sprite_2D.flip_h = character.velocity.x < 0

##Connects to the signal newstate and changes animation_state accordingly
func on_newstate(emitter : Node, previous_state : String, new_state : String):
	#UtilsSingleton.log_data(emitter, self.name, new_state)
	animation_state = new_state
