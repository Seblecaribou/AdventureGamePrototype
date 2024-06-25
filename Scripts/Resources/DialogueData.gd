class_name DialogueData
extends Node

var interactable_id : String
var interactable_label : String
var interactable_portraits : Array[String]
var dialogue_dictionary : Dictionary

##Takes an NPC object and loads the NPC parameters and dialogues in DialogueData
func load_dialogue_data(interactable : Interactable):
	if interactable.interactable_id != null:
		interactable_id = interactable.interactable_id
		interactable_label = interactable.interactable_data.interactable_label
		interactable_portraits = interactable.interactable_data.interactable_portraits
		var file_path = AppSettingsSingleton.base_res_path + AppSettingsSingleton.data_folder_path + AppSettingsSingleton.dialogues_data_folder_path + 'dia_' + interactable_id + '.json'
		dialogue_dictionary = UtilsSingleton.load_json_file(file_path)
	else:
		UtilsSingleton.log_error(self, "load_dialogues_data","Error while loading the dialogue interactable data: no interatable_id was provided.")
