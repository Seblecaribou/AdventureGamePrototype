class_name DialogueManager
extends Node

@export var quest_manager : QuestManager
@export var dialogue_menu : DialogueMenu
@export var dialogue_data : DialogueData
@export var dialogue_component : DialogueComponent
var current_game_state : String
var current_quests_objectives : Array[String]
var current_dialogues : Array[DialogueData.DialogueObjectiveData]


func _ready():
	SignalBusSingleton.newstate.connect(_on_new_state)
	SignalBusSingleton.interacted.connect(_on_player_character_interacted)
	SignalBusSingleton.update_all_quests.connect(_on_update_all_quests)
	SignalBusSingleton.dialogue_button_pressed.connect(_on_dialogue_button_pressed)
	InputManager.pressed_return.connect(_on_pressed_return)
	InputManager.pressed_jump.connect(_on_pressed_jump)


func configure_dialogue(interactable : ):
	for objective in current_quests_objectives:
		var quest_id = objective.get_slice("_", 0)
		var step_id = objective.get_slice("_", 1)
		var objective_id = objective.get_slice("_", 2)
		for dialogue in dialogue_data.dialogues:
			if dialogue.quest_id == quest_id:
				for dialogue_step in dialogue.steps:
					if dialogue_step.step_id == step_id:
						for dialogue_objective in dialogue_step.objectives:
							if dialogue_objective.objective_id == objective_id:
								current_dialogues.append(dialogue_objective)

func reset_dialogue_system() -> void:
	#TODO unload everything in the DialogueData + DialogueComponent to save on memory
	for dialogue in current_dialogues:
		dialogue = null
	current_dialogues.clear()
	dialogue_data.clear_dialogue_data()
	dialogue_component.visible = false
	dialogue_menu.unload_buttons()

#Signals callback functions
func _on_player_character_interacted(emitter : Node, interactable : Interactable, interaction_type : String, player_position : Vector2):
	if interaction_type == "char":
		dialogue_data.load_dialogue_data(interactable)
	configure_dialogue(interactable)
	dialogue_menu.global_position = player_position + AppSettingsSingleton.dialogue_menu_offset
	dialogue_menu.visible = true
	for index in range(current_dialogues.size()):
		var dialogue = current_dialogues[index]
		dialogue_menu.add_button(index, dialogue.objective_id, dialogue.dialogue_button_label)
	dialogue_menu.place_buttons()

func _on_dialogue_button_pressed(button : Node2D):
	var dialogue_to_display
	for dialogue in current_dialogues:
		if button.objective_id == dialogue.objective_id:
			dialogue_component.display_dialogue(dialogue.content[0].dialogue_lines[0])
	dialogue_menu.visible = false


func _on_update_all_quests(emitter : Node, active_quests : Array[QuestData], FinishedQuests : Array[QuestData]):
	for quest in active_quests:
		for step in quest.quest_steps:
			for objective in step.objectives:
				if !objective.success:
					var dialogue_id : String = quest.quest_id + "_" + step.id + "_" + objective.id
					current_quests_objectives.append(dialogue_id)

func _on_new_state(emitter : Node, previous_state : String, new_state : String):
	if emitter.get_name().to_lower() == 'gamestatemachine' and new_state != current_game_state:
		current_game_state = new_state
		#if new_state == "moving" and new_state != previous_state:
			#reset_dialogue_system()
			
func _on_pressed_jump():
	pass
	
func _on_pressed_return():
	if current_game_state == "selectingdialogue":
		reset_dialogue_system()
	
	
