class_name DialogueData
extends Node

var interactable_id : String
var interactable_label : String
var interactable_portraits : Array[String]
var dialogues : Array[DialogueQuestData]

##Takes an NPC object and loads the NPC parameters and dialogues in DialogueData
func load_dialogue_data(interactable : Interactable):
	if interactable.interactable_id != null:
		interactable_id = interactable.interactable_id
		interactable_label = interactable.interactable_data.interactable_label
		interactable_portraits = interactable.interactable_data.interactable_portraits
		var file_path = AppSettingsSingleton.base_res_path + AppSettingsSingleton.data_folder_path + AppSettingsSingleton.dialogues_data_folder_path + 'dia_' + interactable_id + '.json'
		var all_dialogues_dictionary = UtilsSingleton.load_json_file(file_path)
		if all_dialogues_dictionary != null:
			for dialogue in all_dialogues_dictionary["dialogues"]:
				var dialogue_data = DialogueQuestData.new()
				dialogue_data.quest_id = dialogue["quest_id"]
				for step in dialogue["steps"]:
					var dialogue_step = DialogueStepData.new()
					dialogue_step.step_id = step["step_id"]
					for objective in step["objectives"]:
						var dialogue_objective = DialogueObjectiveData.new()
						dialogue_objective.objective_id = objective["objective_id"]
						dialogue_objective.character_id = objective["character_id"]
						for string in objective["content"]:
							dialogue_objective.content.append(string)
						dialogue_step.objectives.append(dialogue_objective)
					dialogue_data.steps.append(dialogue_step)
				dialogues.append(dialogue_data)
			UtilsSingleton.log_data(self, "load_dialogue_data", dialogues[0].quest_id)
	else:
		UtilsSingleton.log_error(self, "load_dialogues_data","Error while loading the dialogue interactable data: no interatable_id was provided.")

class DialogueQuestData:
	extends RefCounted
	var quest_id : String
	var steps : Array[DialogueStepData]

class DialogueStepData:
	extends RefCounted
	var step_id : String
	var objectives : Array[DialogueObjectiveData]

class DialogueObjectiveData:
	extends RefCounted
	var objective_id : String
	var character_id : String
	var content : Array[String]
