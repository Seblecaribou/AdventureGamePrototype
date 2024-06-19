class_name DialogueData
extends Node

var dialogue_id : String
var interactable_label : String
var interactable_portraits : Array[String]
var dialogues_data : Dictionary

##Takes an NPC id and loads the NPC data
func load_interactable_data(interactable : Interactable):
	if interactable.interactable_id != null:
		interactable_label = interactable.interactable_data.interactable_label
		interactable_portraits = interactable.interactable_data.interactable_portraits
	else:
		UtilsSingleton.log_error(self, "load_interactable_data","Error while loading the dialogue interactable data: no interatable_id was provided.")

##Loads dialogues based of an NPC's id
func load_dialogues_data(interactable_id : String):
	var dialogue_file_path = 'dia_' + interactable_id
	if interactable_id != null:
		dialogues_data = UtilsSingleton.load_json_file(dialogue_file_path)
