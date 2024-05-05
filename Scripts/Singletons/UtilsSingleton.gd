extends Node

func load_json_file(filepath : String):
	if FileAccess.file_exists(filepath):
		var data : FileAccess = FileAccess.open(filepath, FileAccess.READ)
		var parsed_data  = JSON.parse_string(data.get_as_text())
		
		if parsed_data is Dictionary:
			return parsed_data
		else: 
			print("An error occured while reading the file. Check the file format.")
	else: 
		print("File does not exists. Check either the filepath or the file at " + filepath)


func save_json_file(file_name : String, data_to_parse):
	var json = JSON.new()
	var file_path : String = "user://" + file_name + ".json"

	var save_file = FileAccess.open(file_path, FileAccess.WRITE)
	save_file.store_string(json.stringify(data_to_parse))
	save_file.close()
	save_file = null
