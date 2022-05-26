extends Control

export (bool) var timed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Timed_pressed():
	get_tree().change_scene("res://Loading.tscn")
	timed = true


func _on_Casual_pressed():
	get_tree().change_scene("res://Loading.tscn")
	timed = false

func _on_Quit_pressed():
	get_tree().quit()
