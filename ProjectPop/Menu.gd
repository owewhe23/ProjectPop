extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Casual_pressed():
	get_tree().change_scene("res://Loading.tscn")


func _on_Quit_pressed():
	get_tree().quit()