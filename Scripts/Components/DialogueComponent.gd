class_name DialogueComponent
extends Node2D

@export var dialogue_frame : Polygon2D
@export var dialogue_text : RichTextLabel
@export var portrait_right : Sprite2D
@export var portrait_left : Sprite2D
var full_text: String = ""
var current_char_index: int = 0
var typing_timer: Timer = null

func _ready():
	start_display_timer()


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

## Displays full dialogue
func display_dialogue(dialogue: String) -> void:
	type_dialogue(dialogue)
	self.visible = true

## Displays dialogue following a typewriter animation
func type_dialogue(dialogue : String) -> void:
	full_text = dialogue
	current_char_index = 0
	dialogue_text.text = ""
	typing_timer.start()

## Enables/disables BBcode animations
func manage_bbcode(isEnabled : bool) -> void:
	dialogue_text.bbcode_enabled = isEnabled

func change_portrait(previous_portrait_id : String, portrait_id : String, portrait_sprite_id : String):
	if previous_portrait_id != portrait_id:
		if portrait_id == "right":
			pass
		else:
			pass


