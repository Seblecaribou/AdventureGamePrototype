class_name DialogueButtonComponent
extends Button

var objective_id : String
var label_content : String

func _ready():
	text = label_content
