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
		print("File does not exists. Check either the filepath or the file.")
