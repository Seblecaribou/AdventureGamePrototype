class_name DialogueComponent
extends Node2D

@export var dialogue_frame : Polygon2D
@export var dialogue_text : RichTextLabel
@export var portrait_right : Sprite2D
@export var portrait_left : Sprite2D
var full_text : String = ""
var current_char_index : int = 0
var typing_timer : Timer = null

func _ready():
	manage_bbcode(AppSettingsSingleton.dialogue_bbcode_enabled)
	start_display_timer()
	

func handle_dialogue_content(dialogue_content : DialogueData.DialogueContentData):
	#Display the character
	if dialogue_content.character_id == "char_chiro":
		load_portrait(portrait_left, AppSettingsSingleton.main_character_id, "happy")
	else:
		load_portrait(portrait_right, dialogue_content.character_id, "happy")
		
	#Display the dialogue lines
	for line in dialogue_content.dialogue_lines:
		display_dialogue(line)
		await get_tree().create_timer(0.1).timeout
		#Skips animation and display full line
		await UtilsSingleton.wait_to_continue()
		typing_timer.stop()
		dialogue_text.text = line
		#Goes to next line
		await get_tree().create_timer(0.1).timeout
		await UtilsSingleton.wait_to_continue()


## Displays full dialogue
func display_dialogue(dialogue: String) -> void:
	type_dialogue(dialogue)
	self.visible = true

##Hide the entire dialogue component and reset text
func hide_dialogue() -> void:
	self.visible = false
	dialogue_text.text = ""

## Displays dialogue following a typewriter animation
func type_dialogue(dialogue : String) -> void:
	full_text = dialogue
	current_char_index = 0
	dialogue_text.text = ""
	typing_timer.start()

func start_display_timer() -> void:
	typing_timer = Timer.new()
	typing_timer.set_wait_time(AppSettingsSingleton.dialogue_display_speed)
	typing_timer.set_one_shot(false)
	typing_timer.timeout.connect(_on_timer_timeout)
	add_child(typing_timer)

func _on_timer_timeout() -> void:
	if current_char_index < full_text.length():
		dialogue_text.text += full_text[current_char_index]
		current_char_index += 1
	else:
		typing_timer.stop()

## Enables/disables BBcode animations
func manage_bbcode(isEnabled : bool) -> void:
	dialogue_text.bbcode_enabled = isEnabled

#Portrait
func load_portrait(portrait : Sprite2D, character_id : String, character_emotion: String) -> void:
	var image_filepath = AppSettingsSingleton.images_folder_path + "Portraits/" + character_id + "_" + character_emotion + ".png"
	portrait.texture = load(image_filepath)
