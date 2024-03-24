extends Node

#Items
var all_items_data : Dictionary = {}
var observable_items : Dictionary = {}
var pickable_items : Dictionary = {}
var actionable_items : Dictionary = {}
var items_json_filepath : String = "res://Data/Items/items.json"

#TODO NPCs
var all_characters_data : Dictionary = {}
var playable_characters : Dictionary = {}
var non_playable_characters : Dictionary = {}
var characters_json_filepath : String = "res://Data/Characters/characters.json"

#TODO Quests
#TODO Dialogues

func _ready():
	all_items_data = load_json_file(items_json_filepath)["Item"]
	all_characters_data = load_json_file(characters_json_filepath)["Character"]
	playable_characters = all_characters_data["Playable"]
	non_playable_characters = all_characters_data["NonPlayable"]
	observable_items = all_items_data["Observable"]
	pickable_items = all_items_data["Pickable"]
	actionable_items = all_items_data["Actionable"]


func load_json_file(filepath : String):
	if FileAccess.file_exists(filepath):
		var data : FileAccess = FileAccess.open(filepath, FileAccess.READ)
		var parsed_data  = JSON.parse_string(data.get_as_text())
		
		if parsed_data is Dictionary:
			return parsed_data
		else: 
			print("An error occured while reading the file. Check the file format.")
	else: 
		print("File does not exists. Check either the filepath or the file.")
