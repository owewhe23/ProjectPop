extends Node2D

export (String) var colour;
var move_tween
var matched = false

func _ready():
	move_tween = get_node("move_tween")

func move(target):
	move_tween.interpolate_property(self, "position", position, target, .3, Tween.TRANS_BACK, Tween.EASE_OUT)
	move_tween.start()

func dim():
	var sprite = get_node("Sprite")
	sprite.modulate = Color(1, 1, 1, 0.5)
