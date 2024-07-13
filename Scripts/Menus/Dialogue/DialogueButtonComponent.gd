class_name DialogueButtonComponent
extends Button

var index : int
var objective_id : String

func _ready():
	visible = false
#TODO Add an override signal "pressed" to send "self" in it
#TODO Load texture
