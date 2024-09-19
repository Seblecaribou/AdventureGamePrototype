#StaticDataSingleton.gd
extends Node

#Items
var all_items_data : Dictionary = {}
var observable_items : Dictionary = {}
var pickable_items : Dictionary = {}
var actionable_items : Dictionary = {}
var items_json_filepath : String = "res://Data/Items/items.json"
var items_folder_path : String = "Items/"

#NPCs
var all_characters_data : Dictionary = {}
var playable_characters : Dictionary = {}
var non_playable_characters : Dictionary = {}
var characters_json_filepath : String = "res://Data/Characters/characters.json"
var characters_folder_path : String = "Characters/"

#Quests
var all_quests_data : Dictionary = {}
var quests_json_filepaths : Array[String] = ["res://Data/Quests/q00.json", "res://Data/Quests/q00.json"]
var quests_folder_path : String = "Quests/"

#Dialogues
var all_dialogues_data : Dictionary = {}
var dialogues_json_filepaths : Array[String] = ["res://Data/Dialogues/dia_char_golot.json"]
var dialogues_folder_path : String = "Dialogues/"

func _ready():
	#Items
	all_items_data = UtilsSingleton.load_json_file(items_json_filepath)["Item"]
	observable_items = all_items_data["Observable"]
	pickable_items = all_items_data["Pickable"]
	actionable_items = all_items_data["Actionable"]
	#Characters
	all_characters_data = UtilsSingleton.load_json_file(characters_json_filepath)["Character"]
	playable_characters = all_characters_data["Playable"]
	non_playable_characters = all_characters_data["NonPlayable"]
	#Quests
	for file_path in quests_json_filepaths:
		all_quests_data.merge( UtilsSingleton.load_json_file(file_path))
	##Dialogues
	#for file_path in dialogues_json_filepaths:
		#all_dialogues_data.merge( UtilsSingleton.load_json_file(file_path))
		
