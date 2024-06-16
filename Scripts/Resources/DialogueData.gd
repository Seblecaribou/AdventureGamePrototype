class_name DialogueData
extends Node

var dialogue_id : String
var interactable_label : String
var interactable_portraits : Array[String]
var quests_objectives : Array[String]

var objectives : Array[String]


##Takes an NPC id and loads the NPC data
func load_interactable_data(interactable : Interactable):
	if interactable.interactable_id != null:
		interactable_label = interactable.interactable_data.interactable_label
		interactable_portraits = interactable.interactable_data.interactable_portraits
	else:
		UtilsSingleton.log_error(self, "load_interactable_data","Error while loading the dialogue interactable data: no interatable_id was provided.")

func load_objectives_data(objectives : Array[String]):
	if !objectives.is_empty():
		quests_objectives = objectives
	else:
		UtilsSingleton.log_error(self, "load_objectives_data","Error while loading the dialogue objectives data: no objectives in the provided array.")

func load_dialogues(dialogue_id):
	pass
