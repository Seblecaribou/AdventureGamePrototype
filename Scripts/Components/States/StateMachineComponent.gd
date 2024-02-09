class_name StateMachineComponent
extends Node

@export var initial_state : StateComponent
@export var player_character : PlayerCharacter
var current_state : StateComponent
var states : Dictionary = {}
signal newstate(previous_state : String, new_state : String)

func _ready():
	for child in get_children():
		if child is StateComponent:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_state_transition)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)
	
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
		transition_state()

func on_state_transition(state : StateComponent, new_state_name : String):
	if state != current_state:
		return
	var current_state_name = current_state.get_name().to_lower()
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state
	newstate.emit(current_state_name, new_state_name)

func transition_state():
	if abs(player_character.velocity.x) < 1:
		current_state.transitioned.emit(current_state, "idle")
	elif abs(player_character.velocity.x) > 1 && player_character.is_on_floor():
		current_state.transitioned.emit(current_state, "run")
	elif not player_character.is_on_floor():
		current_state.transitioned.emit(current_state, "jump")
	pass
