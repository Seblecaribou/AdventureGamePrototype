class_name DialogueData
extends Node

#TODO look at InteractableData script as a template to make this one
var dialogue_id : String
var interactable_label : String

func load_interactable_data(id : String):
	if id:
		pass
	else:
		print("Error while loading the dialogue data: no dialogue_data was provided.")
