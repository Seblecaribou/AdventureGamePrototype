class_name DialogueData
extends Node

#TODO look at InteractableData script as a template to make this one
var dialogue_id : String
var interactable_label : String

##Takes an NPC id and loads the NPC data
func load_interactable_data(id : String):
	if id:
		# Use the StaticDataSingleton to retrieve NPC data using id
		#and assign it to interactable_data
		pass
	else:
		#DEBUG
		print("Error while loading the dialogue data: no dialogue_data was provided.")
