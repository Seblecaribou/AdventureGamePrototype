class_name DialogueComponent
extends Node2D

@export var dialogue_frame : Polygon2D
@export var dialogue_text : RichTextLabel
@export var dialogue_animator : AnimationPlayer
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
		load_portrait(portrait_left, AppSettingsSingleton.main_character_id, "happy", true)
		load_portrait(portrait_right, AppSettingsSingleton.main_character_id, "happy", false)
	else:
		load_portrait(portrait_left, AppSettingsSingleton.main_character_id, "happy", false)
		load_portrait(portrait_right, dialogue_content.character_id, "happy", true)

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
## Loads portrait Sprite2D with an image from Images/Portraits, based of character id and emotion
## Places portrait on the left if main character, and on the right if NPC
func load_portrait(portrait : Sprite2D, character_id : String, character_emotion: String, is_talking : bool) -> void:
	var image_filepath : String
	if is_talking:
		portrait.z_index = 1
		image_filepath = AppSettingsSingleton.images_folder_path + "Portraits/" + character_id + "_" + character_emotion + ".png"
		portrait.texture = load(image_filepath)
		animate_portrait(portrait, character_emotion)
	else:
		portrait.z_index = 0
		image_filepath = AppSettingsSingleton.images_folder_path + "Portraits/" + character_id + "_neutral_bw.png"
		portrait.texture = load(image_filepath)

func animate_portrait(portrait : Sprite2D, character_emotion : String) -> void:
	dialogue_animator.stop()

	var animation = dialogue_animator.get_animation(character_emotion)
	if animation == null:
		UtilsSingleton.log_error(self, "animate_portrait", "No animation found for " + character_emotion + ".")
		return
		
	animation.clear()
	animation.loop_mode = 2
	var portrait_path : String = portrait.get_path()
	
	#Animates portrait based of emotion
	match character_emotion:
		"happy":
			animation.add_track(Animation.TYPE_VALUE)
			animation.track_set_path(0, NodePath(portrait_path + ":scale"))
			animation.track_insert_key(0, 0, Vector2(1, 1))
			animation.track_insert_key(0, 0.5, Vector2(1.2, 1.2))
			animation.track_insert_key(0, 1, Vector2(1, 1))

		"angry":
			animation.add_track(Animation.TYPE_VALUE)
			animation.track_set_path(0, NodePath(portrait_path + ":rotation_degrees"))
			animation.track_insert_key(0, 0, 0)
			animation.track_insert_key(0, 0.5, 10)
			animation.track_insert_key(0, 1, 0)

		"sad":
			animation.add_track(Animation.TYPE_VALUE)
			animation.track_set_path(0, NodePath(portrait_path + ":scale"))
			animation.track_insert_key(0, 0, Vector2(1, 1))
			animation.track_insert_key(0, 0.5, Vector2(0.9, 0.9))
			animation.track_insert_key(0, 1, Vector2(1, 1))

		"surprised":
			animation.add_track(Animation.TYPE_VALUE)
			animation.track_set_path(0, NodePath(portrait_path + ":scale"))
			animation.track_insert_key(0, 0, Vector2(1, 1))
			animation.track_insert_key(0, 0.5, Vector2(1.1, 1.1))
			animation.track_insert_key(0, 1, Vector2(1, 1))
			
		"inquisitive":
			pass

	dialogue_animator.play(character_emotion)

#Sounds
#TODO add sound for each new letter typed in the dialogue
