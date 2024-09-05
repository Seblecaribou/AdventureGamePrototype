class_name StateMachineComponent
extends Node

@export var initial_state : StateComponent
var current_state : StateComponent
var states : Dictionary = {}

func _ready():
	SignalBusSingleton.newstate_query.connect(on_newstate_query)
	for child in get_children():
		if child is StateComponent:
			states[child.name.to_lower()] = child
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state


func on_newstate_query(emitter : Node, state_machine_name : String, newstate_query : String):
	if current_state.name.to_lower() == newstate_query:
		return
	else:
		transition_state(state_machine_name, newstate_query)

func transition_state(state_machine_name : String, newstate_query : String):
	if self.name.to_lower() != state_machine_name:
		return
	else:
		#TODO
		#1/ Transition state internally
		var current_state_name = current_state.get_name().to_lower()
		var new_state = states.get(newstate_query.to_lower())
		if !new_state:
			return
		if current_state:
			current_state.exit()
		new_state.enter()
		current_state = new_state
		#2/ Signal out the new state
		SignalBusSingleton.newstate.emit(self, current_state_name, new_state.name.to_lower())
