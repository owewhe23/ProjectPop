extends Node2D

enum {wait, move}
var state

export (int) var width
export (int) var height
export (int) var x_start
export (int) var y_start
export (int) var offset
export (int) var y_offset

var possible_berries = [
preload("res://Berries/Scenes/BlackBerry.tscn"),
preload("res://Berries/Scenes/Blueberry.tscn"),
preload("res://Berries/Scenes/GreenBerry.tscn"),
preload("res://Berries/Scenes/RedBerry.tscn"),
preload("res://Berries/Scenes/YellowBerry.tscn")
]

var all_berries = []

var berry_one = null
var berry_two = null
var last_place = Vector2(0,0)
var last_direction = Vector2(0,0)
var move_checked = false

var first_click = Vector2(0,0)
var last_click = Vector2(0,0)
var controlling = false

# Called when the node enters the scene tree for the first time.
func _ready():
	state = move
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

func is_in_grid(column, row):
	if column >= 0 && column <= 9:
		if row >= 2 && row <= 11:
			return true
	return false

func click_input():
	if Input.is_action_just_pressed("click"):
		first_click = get_global_mouse_position()
		var grid_position = pixel_to_grid(first_click.x, first_click.y)
		if is_in_grid(grid_position.x, grid_position.y):
			controlling = true
		else:
			controlling = false
	if Input.is_action_just_released("click"):
		last_click = get_global_mouse_position()
		var grid_position = pixel_to_grid(last_click.x, last_click.y)
		if is_in_grid(grid_position.x, grid_position.y) && controlling:
			click_difference(pixel_to_grid(first_click.x, first_click.y), grid_position)
	

func swap_berries(column, row, direction):
	var first_berry = all_berries[column][row]
	var other_berry = all_berries[column + direction.x][row + direction.y]
	if first_berry != null && other_berry != null:
		store_info(first_berry, other_berry, Vector2(column, row), direction)
		state = wait
		all_berries[column][row] = other_berry
		all_berries[column + direction.x][row + direction.y] = first_berry
		first_berry.move(grid_to_pixel(column + direction.x, row + direction.y))
		other_berry.move(grid_to_pixel(column, row))
		if !move_checked:
			find_matches()

func click_difference(grid_1, grid_2):
	var difference = grid_2 - grid_1
	if abs(difference.x) > abs(difference.y):
		if difference.x > 0:
			swap_berries(grid_1.x, grid_1.y-2, Vector2(1, 0))
		elif difference.x < 0:
			swap_berries(grid_1.x, grid_1.y-2, Vector2(-1, 0))
	elif abs(difference.y) > abs(difference.x):
		if difference.y > 0:
			swap_berries(grid_1.x, grid_1.y-2, Vector2(0, 1))
		if difference.y < 0:
			swap_berries(grid_1.x, grid_1.y-2, Vector2(0, -1))

func store_info(first_berry, other_berry, place, direction):
	berry_one = first_berry
	berry_two = other_berry
	last_place = place
	last_direction = direction

func swap_back():
	if berry_one != null && berry_two != null:
		swap_berries(last_place.x, last_place.y, last_direction)
	state = move
	move_checked = false
	pass

func find_matches():
	for i in width:
		for j in height:
			if all_berries[i][j] != null:
				var current_colour = all_berries[i][j].colour
				if i > 0 && i < width - 1:
					if all_berries[i-1][j] != null && all_berries[i+1][j] != null:
						if all_berries[i-1][j].colour == current_colour && all_berries[i+1][j].colour == current_colour:
							all_berries[i-1][j].matched = true
							all_berries[i-1][j].dim()
							all_berries[i][j].matched = true
							all_berries[i][j].dim()
							all_berries[i+1][j].matched = true
							all_berries[i+1][j].dim()
				if j > 0 && j < height - 1:
					if all_berries[i][j-1] != null && all_berries[i][j+1] != null:
						if all_berries[i][j-1].colour == current_colour && all_berries[i][j+1].colour == current_colour:
							all_berries[i][j-1].matched = true
							all_berries[i][j-1].dim()
							all_berries[i][j].matched = true
							all_berries[i][j].dim()
							all_berries[i][j+1].matched = true
							all_berries[i][j+1].dim()
	get_parent().get_node("destroy_timer").start()

func _process(_delta):
	if state == move:
		click_input()

func destroy_matches():
	var was_matched = false
	for i in width:
		for j in height:
			if all_berries[i][j] != null:
				if all_berries[i][j].matched:
					was_matched = true
					all_berries[i][j].queue_free()
					all_berries[i][j] = null
	move_checked = true
	if was_matched:
		get_parent().get_node("collapse_timer").start()
	else:
		swap_back()

func collapse_columns():
	for i in width:
		for j in height:
			if all_berries[i][j] == null:
				for k in range(j+1, height):
					if all_berries[i][k] != null:
						all_berries[i][k].move(grid_to_pixel(i, j))
						all_berries[i][j] = all_berries[i][k]
						all_berries[i][k] = null
						break

func refill_columns():
	for i in width:
		for j in height:
			if all_berries[i][j] == null:
				var rand = floor(rand_range(0, possible_berries.size()))
				var berry = possible_berries[rand].instance()
				var loops = 0
				while(match_at(i, j, berry.colour) && loops <100):
					rand = floor(rand_range(0, possible_berries.size()))
					loops += 1
					berry = possible_berries[rand].instance()
				add_child(berry)
				berry.position = grid_to_pixel(i, j + y_offset)
				berry.move(grid_to_pixel(i, j))
				all_berries[i][j] = berry
	after_refill()

func after_refill():
	for i in width:
		for j in height:
			if all_berries[i][j] != null:
				if match_at(i, j, all_berries[i][j].colour):
					find_matches()
					get_parent().get_node("destroy_timer").start()
					return
	state = move
	move_checked = false
	
func _on_destroy_timer_timeout():
	destroy_matches()

func _on_collapse_timer_timeout():
	collapse_columns()
	get_parent().get_node("refill_timer").start()

func _on_refill_timer_timeout():
	refill_columns()
