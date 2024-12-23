class_name RadialButtonManager
extends Node2D

@export var radial_button_component : Button
@export var button_sprite : Sprite2D
@export var button_label : RichTextLabel
var item_id : String
var index : int
var objective_id : String

func _ready():
	radial_button_component.modulate.a = 0
	radial_button_component.pressed.connect(_on_button_pressed)
	button_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _process(delta: float) -> void:
	if radial_button_component.is_hovered():
		button_label.visible = true
	else:
		button_label.visible = false

#region Methods
func set_up_label():
	button_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
#endregion
	
#region Signal Callbacks
func _on_button_pressed():
	print("Coucou")
	SignalBusSingleton.radial_button_pressed.emit(self)
#endregion
