extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _process(delta):
#	rect_rotation = rect_rotation + 1
#	if rect_rotation >= 360:
#		rect_rotation = 0
#	if rect_rotation >= 90 && rect_rotation < 270:
#		rect_rotation = 270
#	print(rect_rotation)

func _on_Timed_pressed():
	global.timed = true
	get_tree().change_scene("res://Loading.tscn")
	


func _on_Casual_pressed():
	global.timed = false
	get_tree().change_scene("res://Loading.tscn")
	

func _on_Quit_pressed():
	get_tree().quit()
