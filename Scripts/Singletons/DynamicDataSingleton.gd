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
	#Load all the default data if no save files
	pass

func load_save(save : Dictionary, save_file_name: String) -> Dictionary:
	#TODO define savefile name then load data and return as Dictionary
	save = UtilsSingleton.load_json_file(base_path + save_file_name + ".json")
	if save == null:
		save = UtilsSingleton.load_json_file(base_path + "default_" + save_file_name + ".json")
	return save
