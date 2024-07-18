class_name GameStateMachine
extends StateMachineComponent

var menu_states : Array[String] = ["pause", "journal", "interacting"]

func _ready():
	super()
	SignalBusSingleton.interacted.connect(_on_interacted)
	SignalBusSingleton.dialogue_button_pressed.connect(_on_dialogue_button_pressed)
	
	
func transition_state():
	#TODO Convert into Signals coming from SignalBusSingleton
	#if Input.is_action_just_pressed("pause"):
		#current_state.transitioned.emit(current_state, "pause")
	#if Input.is_action_just_pressed("journal"):
		#current_state.transitioned.emit(current_state, "journal")
	
	#TODO: remplacer par un changement de state si on sort du menu concerné
	if  check_is_in_menu() and Input.is_action_just_pressed("return"):
		current_state.transitioned.emit(current_state, "moving")
	if not check_is_in_menu():
		current_state.transitioned.emit(current_state, "moving")
	

func check_is_in_menu() -> bool: 
	if menu_states.has(current_state.get_name().to_lower()):
		return true
	else : 
		return false

func _on_interacted(emitter : Node, interactable : Interactable, interaction_type : String, player_position : Vector2):
	if interaction_type == "char":
		current_state.transitioned.emit("selectingdialogue")
		
func _on_dialogue_button_pressed():
	current_state.transitioned.emit("dialoguing")
	
