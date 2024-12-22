class_name MovementComponent
extends Node

@export var character: CharacterBody2D
@export var speed: float = 300.0
@export var jump_velocity: float = -700.0
@export var max_speed_multiplier: float = 3.2
@export var interaction_area : Area2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const BASE_SPEED_MULTIPLIER: float = 2.0
var speed_multiplier: float = 2.0 #variable that equals either max_speed_multiplier or BASE_SPEED_MULTIPLIER

func _ready():
	character.floor_snap_length = 50.0
	character.set_collision_layer_value(1, false)

func _physics_process(delta):
	ground_player(delta)

##Adds jump_velocity (a negative float) to a CharacterBody2D's velocity.y 
func jump() -> void:
	if character.is_on_floor():
		character.velocity.y = jump_velocity


##Adds gravity to CharacterBody2D's velocity.y
func ground_player(delta: float) -> void:
	if not character.is_on_floor():
		SignalBusSingleton.newstate_query.emit(self, "playerstatemachine", "jump")
		character.velocity.y += gravity * delta
		

##Handles a CharacterBody2D left and right movement
func move(direction: float) -> void:
	if direction:
		character.velocity.x = direction * speed * speed_multiplier
		if character.is_on_floor():
			SignalBusSingleton.newstate_query.emit(self, "playerstatemachine", "run")
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, speed)
	character.move_and_slide()


##Changes the speed_multiplier value (used in move() function) depending on the value of the bool "running"
func run(running: bool) -> void:
	if running:
		speed_multiplier = max_speed_multiplier
	else:
		speed_multiplier = BASE_SPEED_MULTIPLIER


##Moves the character from an entrance layer to an exit layer
##Both layers are connected through an "EntranceBackground" (Area2D) 
func change_collision_layer(direction : String, transition_area : String) -> void:
	var entrance_layer_number : int = int(transition_area.trim_prefix("EntranceBackground"))
	var exit_layer_number : int = entrance_layer_number + 1
	UtilsSingleton.log_data(self, "change_collision_layer - entrance_layer_number", entrance_layer_number)
	var current_player_x_scale : float = character.get_scale().x
	var current_player_y_scale : float = character.get_scale().y
	match direction:
		#Player goes further back from the camera
		"up":
			character.set_scale(Vector2(current_player_x_scale - 0.15 ,current_player_y_scale - 0.15))
			#We add the player to the exit collision layer
			character.set_collision_layer_value(exit_layer_number, true)
			character.set_collision_mask_value(exit_layer_number, true)
			#We remove the player from the entrance collision layer
			character.set_collision_layer_value(entrance_layer_number, false)
			character.set_collision_mask_value(entrance_layer_number, false)
			#We change the InteractionArea's masks so that it is visible for the correct layer (i.e the exit layer)
			interaction_area.set_collision_mask_value(exit_layer_number, true)
			interaction_area.set_collision_mask_value(entrance_layer_number, false)
		#Player comes closer to the camera
		"down":
			character.set_scale(Vector2(current_player_x_scale + 0.15, current_player_y_scale + 0.15))
			#We add the player to the entrance collision layer
			character.set_collision_layer_value(entrance_layer_number, true)
			character.set_collision_mask_value(entrance_layer_number, true)
			#We remove the player from the exit collision layer
			character.set_collision_layer_value(exit_layer_number, false)
			character.set_collision_mask_value(exit_layer_number, false)
			#We change the InteractionArea's masks so that it is visible for the correct layer (i.e the entrance layer)
			interaction_area.set_collision_mask_value(exit_layer_number, false)
			interaction_area.set_collision_mask_value(entrance_layer_number, true)
