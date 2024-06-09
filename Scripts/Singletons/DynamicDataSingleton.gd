#DynamicDataSingleton.gd
extends Node

var base_path : String = "user://"

#Save files to load
var quest_save : Dictionary
var quest_file_name : String = "quest_save"

var inventory_save : Dictionary
var inventory_file_name : String = "inventory_save"

var rooms_save : Dictionary 
var rooms_file_name : String = "rooms_save"

var characters_save : Dictionary
var characters_file_name : String = "characters_save"

func _ready():
	quest_save = load_save(quest_save, quest_file_name)
	#TODO Load all the default data if no save files
	#inventory_save
	#rooms_save
	#characters_save

func load_save(save : Dictionary, save_file_name: String) -> Dictionary:
	var file_path : String = base_path + save_file_name + ".json"
	if FileAccess.file_exists(file_path):
		save = UtilsSingleton.load_json_file(file_path)
	else:
		save = UtilsSingleton.load_json_file(base_path + "default_" + save_file_name + ".json")
	return save
	
func save(save_file_name : String, save_dictionary : Dictionary):
	var file_path : String = base_path + save_file_name + ".json"
	UtilsSingleton.save_json_file(save_file_name, save_dictionary)
