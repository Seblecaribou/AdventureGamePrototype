class_name StateMachineComponent
extends Node

@export var initial_state : StateComponent
var current_state : StateComponent
var states : Dictionary = {}

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
	SignalBusSingleton.newstate.emit(current_state_name, new_state_name)

func transition_state():
	pass
