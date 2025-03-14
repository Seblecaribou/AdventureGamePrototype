#UtilsSingleton.gd
extends Node

func load_json_file(file_path : String):
	if FileAccess.file_exists(file_path):
		var data : FileAccess = FileAccess.open(file_path, FileAccess.READ)
		var parsed_data = JSON.parse_string(data.get_as_text())
		data.close()
		data = null
		
		if parsed_data is Dictionary:
			return parsed_data
		else:
			print("An error occured while reading the file. Check the file format or the file at " + file_path)
	else: 
		print("The file does not exists. Check either the filepath or the file at " + file_path)


func save_json_file(file_name : String, data_to_parse : Dictionary):
	var file_path : String = "user://" + file_name + ".json"

	var save_file = FileAccess.open(file_path, FileAccess.WRITE)
	save_file.store_string(JSON.stringify(data_to_parse))
	save_file.close()
	save_file = null

func log_data(emitter : Node, label : String, data):
	print_rich("[color=green]", emitter, " : ", "[/color]")
	print_rich("[color=green]", label, " : ", data, "[/color]")
	
func log_error(emitter : Node, label : String, message : String):
	print_rich("[color=red]", emitter, " : ", "[/color]")
	print_rich("[color=red]", label, " : ", message, "[/color]")

func wait_to_continue() -> void:
	while true:
		if Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("jump"):
			return
		await get_tree().process_frame

func wait_to_skip() -> void:
	while true:
		if Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("jump"):
			break
		await get_tree().process_frame
