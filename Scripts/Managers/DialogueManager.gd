class_name DialogueManager
extends Node

@export var quest_manager : QuestManager
@export var dialogue_data : DialogueData
@export var dialogue_component : DialogueComponent
var current_quests_objectives : Array[String]
var current_dialogues : Array[String]


func _ready():
	SignalBusSingleton.interacted.connect(on_player_character_interacted)
	SignalBusSingleton.update_all_quests.connect(on_update_all_quests)
	#TODO get the current quest step from the quest manager signal
	

func display_dialogue() -> void:
	#TODO make dialogue appear in DialogueFrame if Interaction calls it
	for dialogue in current_dialogues:
		dialogue_component.type_dialogue(dialogue)
	
func hide_dialogue() -> void:
	dialogue_component.visible = false

func configure_dialogue(interactable : ):
	#TODO loads dialogues based of current_quests_steps and current_character
	for objective in current_quests_objectives:
		var quest_id = objective.get_slice("_", 0)
		var step_id = objective.get_slice("_", 1)
		var objective_id = objective.get_slice("_", 2)
		for dialogue in dialogue_data.dialogues:
			pass
		pass 
	pass


#Signal callback functions
func on_player_character_interacted(emitter : Node, interactable : Interactable, interaction_type : String):
	if interaction_type == "char":
		dialogue_data.load_dialogue_data(interactable)
	configure_dialogue(interactable)
	#dialogue_component.display_dialogue()

func on_update_all_quests(emitter : Node, active_quests : Array[QuestData], FinishedQuests : Array[QuestData]):
	#TODO implement recuperation of data active/finished quest
	for quest in active_quests:
		for step in quest.quest_steps:
			for objective in step.objectives:
				if !objective.success:
					var dialogue_id : String = quest.quest_id + "_" + step.id + "_" + objective.id
					current_quests_objectives.append(dialogue_id)
