class_name PlayerCharacter
extends CharacterBody2D

@export var interaction_component : InteractionComponent
@export var movement_component : MovementComponent
var current_game_state : String
var current_held_item : String
var transition_area_name : String
var inside_transition_area : bool
var inside_teleport_entrance : bool = false
var current_teleport_area : Node

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	current_game_state = "moving"
	SignalBusSingleton.newstate.connect(_on_new_game_state)
	SignalBusSingleton.new_selected_item.connect(_on_new_selected_item)
	SignalBusSingleton.in_teleport_entrance.connect(_on_in_teleport_entrance)
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
			
		#Second Interact Button
		if Input.is_action_just_pressed("second_interact") and inside_teleport_entrance:
			if current_teleport_area:
				teleport(current_teleport_area)

		##InteractionComponent
		#Interact Button
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

func teleport(area : Node) -> void:
		var arrival_area : String = area.name.substr(8)
		var arrival_area_node : Node = interaction_component.get_teleport_arrival_area_node(arrival_area)
		if TeleportDictionarySingleton.get(arrival_area) and arrival_area_node:
			var teleport_data : Dictionary = TeleportDictionarySingleton.get(arrival_area)
			SignalBusSingleton.teleported.emit(self, self.z_index, arrival_area, teleport_data, arrival_area_node)
		else:
			UtilsSingleton.log_error(self, "_on_interaction_area_area_entered", "Missing teleportation information.")
		current_teleport_area = null
		inside_teleport_entrance = false

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

func _on_in_teleport_entrance(emitter : Node, area_node : Node) -> void:
	inside_teleport_entrance = true
	current_teleport_area = area_node
	print(area_node)
#region
