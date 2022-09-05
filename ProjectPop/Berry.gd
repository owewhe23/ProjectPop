extends Node2D

export (String) var colour;
export (Texture) var row_texture
export (Texture) var column_texture
export (Texture) var adjacent_texture
export (Texture) var colour_bomb_texture

var is_row_bomb = false
var is_adjacent_bomb = false
var is_column_bomb = false
var is_colour_bomb = false

var move_tween
var matched = false

func _ready():
	move_tween = get_node("move_tween")

func move(target):
	move_tween.interpolate_property(self, "position", position, target, .3, Tween.TRANS_BACK, Tween.EASE_OUT)
	move_tween.start()

func make_colour_bomb():
	is_colour_bomb = true
	$Sprite.texture = colour_bomb_texture
	$Sprite.modulate = Color(1, 1, 1, 1)
	scale.x = 0.5
	scale.y = 0.5
	colour = "Colour"

func make_column_bomb():
	is_column_bomb = true
	$Sprite.texture = column_texture
	$Sprite.modulate = Color(1, 1, 1, 1)
	scale.x = 1
	scale.y = 1
	

func make_row_bomb():
	is_row_bomb = true
	$Sprite.texture = row_texture
	$Sprite.modulate = Color(1, 1, 1, 1)
	scale.x = 1
	scale.y = 1

func make_adjacent_bomb():
	is_adjacent_bomb = true
	$Sprite.texture = adjacent_texture
	$Sprite.modulate = Color(1, 1, 1, 1)
	scale.x = 1
	scale.y = 1

func dim():
	var sprite = get_node("Sprite")
	sprite.modulate = Color(1, 1, 1, 0.5)
	scale.x = 1
	scale.y = 1
