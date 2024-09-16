#DynamicDataSingleton.gd
extends Node

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
	quest_save = load_save(quest_save, quest_file_name, AppSettingsSingleton.quests_data_folder_path, true)
	#TODO Load all the default data if no save files
	#inventory_save
	#rooms_save
	#characters_save

func load_save(save_dictionary : Dictionary, save_file_name: String, save_default_directory : String = "", default : bool = false) -> Dictionary:
	var file_path : String = AppSettingsSingleton.base_user_path + save_file_name + ".json"
	if default || !FileAccess.file_exists(file_path):
		var default_file_path = AppSettingsSingleton.base_res_path + AppSettingsSingleton.data_folder_path + save_default_directory + "default_" + save_file_name + ".json"
		save_dictionary = UtilsSingleton.load_json_file(default_file_path)
	else:
		save_dictionary = UtilsSingleton.load_json_file(file_path)
	return save_dictionary
	
func save(save_file_name : String, save_dictionary : Dictionary):
	var file_path : String = AppSettingsSingleton.base_user_path + save_file_name + ".json"
	UtilsSingleton.save_json_file(save_file_name, save_dictionary)
