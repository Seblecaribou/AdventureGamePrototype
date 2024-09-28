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
	SignalBusSingleton.newstate.connect(_on_newstate)
	SignalBusSingleton.interacted.connect(_on_player_character_interacted)
	SignalBusSingleton.update_all_quests.connect(_on_update_all_quests)
	SignalBusSingleton.dialogue_button_pressed.connect(_on_dialogue_button_pressed)

func _process(delta):
	check_input()

#region Methods
func configure_dialogue(interactable : Interactable):
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
	for dialogue in current_dialogues:
		dialogue = null
	current_dialogues.clear()
	dialogue_data.clear_dialogue_data()
	dialogue_component.visible = false
	dialogue_menu.unload_buttons()


func check_input() -> void:
	#ReturnButton
	if Input.is_action_just_pressed("return"):
		if current_game_state == "selectingdialogue":
			SignalBusSingleton.newstate_query.emit(self, "gamestatemachine", "moving")
			reset_dialogue_system()
		if current_game_state == "dialoguing":
			SignalBusSingleton.newstate_query.emit(self, "gamestatemachine", "selectingdialogue")
			dialogue_component.hide_dialogue()
			dialogue_menu.visible = true
#endregion


#region Signals callback functions
func _on_newstate(emitter : Node, previous_state : String, new_state : String)-> void :
	if emitter.get_name().to_lower() == 'gamestatemachine' and new_state != current_game_state:
		current_game_state = new_state

func _on_player_character_interacted(emitter : Node, interactable : Interactable, interaction_type : String, player_position : Vector2) -> void:
	if interaction_type == "char":
		SignalBusSingleton.newstate_query.emit(self, "gamestatemachine", "selectingdialogue")
		dialogue_data.load_dialogue_data(interactable)
	configure_dialogue(interactable)
	dialogue_menu.global_position = player_position + AppSettingsSingleton.dialogue_menu_offset
	dialogue_menu.visible = true
	for index in range(current_dialogues.size()):
		var dialogue = current_dialogues[index]
		dialogue_menu.add_button(index, dialogue.objective_id, dialogue.dialogue_button_label)
	dialogue_menu.place_buttons()

func _on_update_all_quests(emitter : Node, active_quests : Array[QuestData], FinishedQuests : Array[QuestData]) -> void:
	for quest in active_quests:
		for step in quest.quest_steps:
			for objective in step.objectives:
				if !objective.success:
					var dialogue_id : String = quest.quest_id + "_" + step.id + "_" + objective.id
					current_quests_objectives.append(dialogue_id)

func _on_dialogue_button_pressed(button : Node2D) -> void:
	for dialogue in current_dialogues:
		if button.objective_id == dialogue.objective_id:
			SignalBusSingleton.newstate_query.emit(self, "gamestatemachine", "dialoguing")
			dialogue_menu.visible = false
			for dialogue_content in dialogue.content:
				await dialogue_component.handle_dialogue_content(dialogue_content)
			dialogue_component.visible = false
			dialogue_menu.visible = true
#endregion
