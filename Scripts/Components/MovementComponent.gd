class_name MovementComponent
extends Node

@export var character: PlayerCharacter
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
	SignalBusSingleton.teleported.connect(_on_teleported)

func _physics_process(delta):
	ground_player(delta)


#region Methods
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
	#Determines how much is added/substracted to the player's scale when moving forward or backward
	var scale_factor : float = 0.06
	var entrance_layer_number : int = int(transition_area.trim_prefix("EntranceBackground"))
	var exit_layer_number : int = entrance_layer_number + 1
	var current_player_x_scale : float = character.get_scale().x
	var current_player_y_scale : float = character.get_scale().y
	match direction:
		#Player goes further back from the camera
		"up":
			#We check if player is allowed to move up
			if character.get_collision_layer_value(exit_layer_number):
				return
			#We scale down the character to look smaller, because he's going away from camera
			character.scale_character(exit_layer_number)
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
			#We check if player is allowed to move down
			if character.get_collision_layer_value(entrance_layer_number):
				return
			#We scale up the character to look bigger, because he's coming closer to camera
			character.scale_character(entrance_layer_number)
			#We add the player to the entrance collision layer
			character.set_collision_layer_value(entrance_layer_number, true)
			character.set_collision_mask_value(entrance_layer_number, true)
			#We remove the player from the exit collision layer
			character.set_collision_layer_value(exit_layer_number, false)
			character.set_collision_mask_value(exit_layer_number, false)
			#We change the InteractionArea's masks so that it is visible for the correct layer (i.e the entrance layer)
			interaction_area.set_collision_mask_value(exit_layer_number, false)
			interaction_area.set_collision_mask_value(entrance_layer_number, true)
#region

#region Signal Callback functions
func _on_teleported(emitter : Node, player_z: int, arrival_area : String, arrival_area_data : Dictionary, arrival_node : CollisionShape2D) -> void:
	#We reset every background/forground collision
	for i in range(1,33):
		character.set_collision_layer_value(i, false)
		character.set_collision_mask_value(i, false)
	#We set the collision layer and mask to the one the player is arriving in  
	character.set_collision_layer_value(arrival_area_data.collision_mask, true)
	character.set_collision_mask_value(arrival_area_data.collision_mask, true)
	#Sets player's new global position and scale
	character.scale_character(arrival_area_data.collision_mask)
	character.global_position = arrival_node.global_position
	
	#We reset the collision mask for interaction area
	for i in range(1,33):
		interaction_area.set_collision_mask_value(i, false)
	interaction_area.set_collision_mask_value(arrival_area_data.collision_mask, true)
#region
