class_name PlayerCharacter
extends CharacterBody2D

@export var interaction_component : InteractionComponent
@export var movement_component : MovementComponent
var current_game_state : String
var current_held_item : String
var transition_area_name : String
var inside_transition_area : bool

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	current_game_state = "moving"
	SignalBusSingleton.newstate.connect(_on_new_game_state)
	SignalBusSingleton.new_selected_item.connect(_on_new_selected_item)
	SignalBusSingleton.teleported.connect(_on_teleported)
	interaction_component.in_transition_area.connect(_on_in_transition_area)

func _physics_process(delta):
	check_input()

#region Methods
func check_input() -> void:
	if current_game_state == "moving":
		##Idle
		if abs(self.velocity.x) < 1 and self.is_on_floor():
			SignalBusSingleton.newstate_query.emit(self, "playerstatemachine", "idle")
			
		##MovementComponent
		#Direction buttons
		var direction: float = Input.get_axis("left", "right")
		movement_component.move(direction)
		
		#UP Button
		if Input.is_action_just_pressed("up"):
			if inside_transition_area:
				movement_component.change_collision_layer("up", transition_area_name)
				SignalBusSingleton.transitioned_area.emit(self, true, self.z_index, transition_area_name)
			
		#DOWN Button
		if Input.is_action_just_pressed("down"):
			if inside_transition_area:
				movement_component.change_collision_layer("down", transition_area_name)
				SignalBusSingleton.transitioned_area.emit(self, false, self.z_index, transition_area_name)

		#Jump Button
		if Input.is_action_just_pressed("jump"):
			movement_component.jump()

		#Run Button
		if Input.is_action_pressed("run"):
			movement_component.run(true)
		else: 
			movement_component.run(false)

		##InteractionComponent
		if Input.is_action_just_pressed("interact"):
			interaction_component.interact(current_held_item)

		##Menus
		#RadialMenu Button
		if Input.is_action_just_pressed("inventory"):
			SignalBusSingleton.newstate_query.emit(self, "gamestatemachine", "selectingpickable")
		
		#Return Button
		if Input.is_action_just_pressed("return"):
			pass
		
		#Pause Button
		if Input.is_action_just_pressed("pause"):
			pass
			
		#Journal Button
		if Input.is_action_just_pressed("journal"):
			pass
			
	if current_game_state == "examining":
		if Input.is_action_just_pressed("return"):
			SignalBusSingleton.newstate_query.emit(self, "gamestatemachine", "moving")


func scale_character(layer : int) -> void:
	var scale_factor : float = 0.06
	match layer:
		1: #Forground
			self.set_scale(Vector2(1 + scale_factor, 1 + scale_factor))
		2: #Main
			self.set_scale(Vector2(1,1))
		3: #Background1
			self.set_scale(Vector2(1 - scale_factor , 1 - scale_factor))
		4: #Background2
			self.set_scale(Vector2(1 - (2 * scale_factor) , 1 - (2 * scale_factor)))
#region

#region Signal Callback fuctions
func _on_new_game_state(emitter : Node, previous_state : String, new_state : String):
	if emitter.get_name().to_lower() == 'gamestatemachine':
		current_game_state = new_state
		
func _on_new_selected_item(emitter : Node, item_id : String) -> void:
	if current_held_item != item_id:
		current_held_item = item_id
		print("**PlayerCharacter** _on_new_selected_item : ", current_held_item)
		
func _on_in_transition_area(emitter : Node, inside : bool, entrance_name :String) -> void:
	transition_area_name = entrance_name
	inside_transition_area = inside

func _on_teleported(emitter : Node, player_z : int, arrival_area : String, arrival_area_data : Dictionary) -> void:
	scale_character(arrival_area_data.collision_mask)
#region
