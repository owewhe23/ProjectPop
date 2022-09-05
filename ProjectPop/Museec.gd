extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if get_tree().get_current_scene().get_name() == "Menu":
		$AnimationPlayer.play("Menu")
	if get_tree().get_current_scene().get_name() == "Main":
		$AnimationPlayer.play("Main")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
