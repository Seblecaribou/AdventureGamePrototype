class_name PlayerCharacter
extends CharacterBody2D

@export var interaction_component : InteractionComponent
@export var movement_component : MovementComponent
var current_game_state : String

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	current_game_state = "moving"
	SignalBusSingleton.newstate.connect(on_new_game_state)

func _physics_process(delta):
	check_input()

func check_input() -> void:
	if current_game_state == "moving":
		##Idle
		if abs(self.velocity.x) < 1 and self.is_on_floor():
			SignalBusSingleton.newstate_query.emit(self, "playerstatemachine", "idle")
			
		##MovementComponent
		#Direction buttons
		var direction: float = Input.get_axis("left", "right")
		movement_component.move(direction)
		
		#Jump Button
		if Input.is_action_just_pressed("jump"):
			movement_component.jump()

		#Run Button
		if Input.is_action_pressed("run"):
			movement_component.run(true)

		##InteractionComponent
		if Input.is_action_just_pressed("interact"):
			interaction_component.interact()

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


func on_new_game_state(emitter : Node, previous_state : String, new_state : String):
	if emitter.get_name().to_lower() == 'gamestatemachine':
		current_game_state = new_state
