class_name DialogueComponent
extends Node2D

@export var dialogue_frame : Polygon2D
@export var dialogue_text : RichTextLabel
@export var portrait_right : Sprite2D
@export var portrait_left : Sprite2D

#TODO take string to display, animate and change them
## Displays full dialogue
func display_dialogue(dialogue: String) -> void:
	type_dialogue(dialogue)
	self.visible = true

## Displays dialogue following a typewriter animation
func type_dialogue(dialogue : String) -> void:
	dialogue_text.visible = 0.0
	dialogue_text.text = dialogue
	var tween: Tween = create_tween()
	tween.tween_property(dialogue_text, "visible_ratio", 1.0, 2.0).from(0.0)

## Enables/disables BBcode animations
func manage_bbcode(isEnabled : bool) -> void:
	dialogue_text.bbcode_enabled = isEnabled

func change_portrait(portrait_id : String, portrait_sprite_id : String):
	if portrait_id == "right":
		pass
	else:
		pass
