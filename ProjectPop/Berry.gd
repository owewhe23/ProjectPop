extends Node2D

export (String) var colour;
var move_tween


func _ready():
	move_tween = get_node("move_tween")

func move(target):
	move_tween.interpolate_property(self, "position", position, target, .3, Tween.TRANS_BACK, Tween.EASE_OUT)
	move_tween.start()
