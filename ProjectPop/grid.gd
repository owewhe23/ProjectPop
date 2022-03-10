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

var first_click = Vector2(0,0)
var last_click = Vector2(0,0)

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
			var loops = 0
			while(match_at(i, j, berry.colour) && loops <100):
				rand = floor(rand_range(0, possible_berries.size()))
				loops += 1
				berry = possible_berries[rand].instance()
			add_child(berry)
			berry.position = grid_to_pixel(i, j)
			all_berries[i][j] = berry

func match_at(i, j, colour):
	if i > 1:
		if all_berries[i - 1][j] != null && all_berries[i - 2][j] != null:
			if all_berries[i - 1][j].colour == colour && all_berries[i - 2][j].colour == colour:
				return true
	if j > 1:
		if all_berries[i][j - 1] != null && all_berries[i][j - 2] != null:
			if all_berries[i][j - 1].colour == colour && all_berries[i][j - 2].colour == colour:
				return true

func grid_to_pixel(column, row):
	var new_x = x_start + offset * column
	var new_y = x_start + -offset * row
	return Vector2(new_x, new_y)

func pixel_to_grid(pixel_x, pixel_y):
	var new_x = round((pixel_x - x_start) / offset)
	var new_y = round((pixel_y - y_start) / -offset)
	return Vector2(new_x, new_y)

func click_input():
	if Input.is_action_just_pressed("click"):
		first_click = get_global_mouse_position()
		var grid_position = pixel_to_grid(first_click.x, first_click.y)
		print(grid_position)
	if Input.is_action_just_released("click"):
		last_click = get_global_mouse_position()

func _process(delta):
	click_input()
