extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	print(get_tree().get_current_scene().get_name())
	if get_tree().get_current_scene().get_name() == "Menu":
		$AnimationPlayer.play("Menu")
	if get_tree().get_current_scene().get_name() == "gamewindow":
		$AnimationPlayer.play("Main")
