class_name DialogueButtonComponent
extends Button

var index : int
var objective_id : String

func _ready():
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	return self
