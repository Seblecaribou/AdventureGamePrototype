class_name DialogueManager
extends Node

@export var quest_manager : QuestManager
@export var dialogue_data : DialogueData
@export var dialogue_component : DialogueComponent
var current_quests_objectives : Array[String]
var current_dialogues : Array[DialogueData.DialogueObjectiveData]


func _ready():
	SignalBusSingleton.newstate.connect(_on_new_state)
	SignalBusSingleton.interacted.connect(on_player_character_interacted)
	SignalBusSingleton.update_all_quests.connect(on_update_all_quests)
	#TODO get the current quest step from the quest manager signal
	

func hide_dialogue() -> void:
	#TODO unload everything in the DialogueData + DialogueComponent to save on memory
	dialogue_component.visible = false

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

#Signals callback functions
func on_player_character_interacted(emitter : Node, interactable : Interactable, interaction_type : String):
	if interaction_type == "char":
		dialogue_data.load_dialogue_data(interactable)
	configure_dialogue(interactable)
	for dialogue in current_dialogues:
		for content in dialogue.content:
			dialogue_component.display_dialogue(content)

func on_update_all_quests(emitter : Node, active_quests : Array[QuestData], FinishedQuests : Array[QuestData]):
	#TODO implement recuperation of data active/finished quest
	for quest in active_quests:
		for step in quest.quest_steps:
			for objective in step.objectives:
				if !objective.success:
					var dialogue_id : String = quest.quest_id + "_" + step.id + "_" + objective.id
					current_quests_objectives.append(dialogue_id)


func _on_new_state(emitter : Node, previous_state : String, new_state : String):
	if emitter.get_name().to_lower() == 'gamestatemachine':
		if new_state == "moving" and new_state != previous_state:
			hide_dialogue()
