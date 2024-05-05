#UtilsSingleton.gd
extends Node

func load_json_file(file_path : String):
	if FileAccess.file_exists(file_path):
		var data : FileAccess = FileAccess.open(file_path, FileAccess.READ)
		var parsed_data  = JSON.parse_string(data.get_as_text())
		data.close()
		data = null
		
		if parsed_data is Dictionary:
			return parsed_data
		else: 
			print("An error occured while reading the file. Check the file format or the file at " + file_path)
	else: 
		print("The file does not exists. Check either the filepath or the file at " + file_path)


func save_json_file(file_name : String, data_to_parse):
	var json = JSON.new()
	var file_path : String = "user://" + file_name + ".json"

	var save_file = FileAccess.open(file_path, FileAccess.WRITE)
	save_file.store_string(json.stringify(data_to_parse))
	save_file.close()
	save_file = null
