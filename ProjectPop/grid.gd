extends Node2D

export (int) var width
export (int) var height
export (int) var x_start
export (int) var y_start
export (int) var offset

var possible_berries = [
preload("res://Berries/Scenes/BlackBerry.tscn"),
preload("res://Berries/Scenes/Blueberry.tscn"),
preload("res://Berries/Scenes/GreenBerry.tscn"),
preload("res://Berries/Scenes/RedBerry.tscn"),
preload("res://Berries/Scenes/YellowBerry.tscn")
]

var all_berries = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	all_berries = make_2d_array()
	spawn_berries()

func make_2d_array():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array

func spawn_berries():
	for i in width:
		for j in height:
			var rand = floor(rand_range(0, possible_berries.size()))
			var berry = possible_berries[rand].instance()
			add_child(berry)
			berry.position = grid_to_pixel(i, j)

func grid_to_pixel(column, row):
	var new_x = x_start + offset * column
	var new_y = x_start + -offset * row
	return Vector2(new_x, new_y)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
