class_name MovementComponent
extends Node

@export var character: CharacterBody2D
@export var speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var max_speed_multiplier: float = 1.75
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const BASE_SPEED_MULTIPLIER: float = 1.0
var speed_multiplier: float = 1.0 #variable that equals either max_speed_multiplier or BASE_SPEED_MULTIPLIER


func _physics_process(delta):
	ground_player(delta)


##Adds jump_velocity (a negative float) to a CharacterBody2D's velocity.y 
func jump() -> void:
	if character.is_on_floor():
		character.velocity.y = jump_velocity

##Adds gravity to CharacterBody2D's velocity.y
func ground_player(delta: float) -> void:
	if not character.is_on_floor():
		character.velocity.y += gravity * delta

##Handles a CharacterBody2D left and right movement
func move(direction: float) -> void:
	if direction:
		character.velocity.x = direction * speed * speed_multiplier
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, speed)
	character.move_and_slide()

##Changes the speed_multiplier value (used in move() function) depending on the value of the bool "running"
func run(running: bool) -> void:
	if running:
		speed_multiplier = max_speed_multiplier
	else:
		speed_multiplier = BASE_SPEED_MULTIPLIER
