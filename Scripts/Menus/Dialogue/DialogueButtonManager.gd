class_name DialogueButtonManager
extends Node2D

@export var dialogue_button_component : Button
@export var button_sprite : AnimatedSprite2D
@export var button_label : RichTextLabel
var index : int
var objective_id : String

func _ready():
	dialogue_button_component.modulate.a = 0
	dialogue_button_component.pressed.connect(_on_button_pressed)
	button_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	#TODO Load texture
	pass

func set_up_label():
	button_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	
func _on_button_pressed():
	SignalBusSingleton.dialogue_button_pressed.emit(self)
