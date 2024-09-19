@tool
class_name RadialMenuComponent
extends Control

@export var player_character : PlayerCharacter
@export var background_color : Color
@export var line_color : Color
@export var inner_radius : int = 64
@export var line_width : int = 4
@export var outer_radius : int = 256

func _draw() -> void:
	draw_circle(Vector2.ZERO, outer_radius, background_color)
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width, true)

func _process(delta: float) -> void:
	queue_redraw()
