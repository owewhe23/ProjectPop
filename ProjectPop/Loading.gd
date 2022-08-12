extends Node2D

var timer
var rng = RandomNumberGenerator.new()
var tip_num = RandomNumberGenerator.new()
var tip

func _ready():
	$AnimationPlayer.play("LOAD")
	#$AudioStreamPlayer2D.play()
	rng.randomize()
	tip_num.randomize()
	timer = get_node("Timer")
	var time = rng.randf_range(3.0, 15.0)
	$Timer.set_wait_time(time)
	$Timer.start()
	tip = tip_num.randf_range(1, 11)
	tips()

func tips():
	if tip < 2:
		$Tips.text = ("Press 'Escape' to return to the menu")
	elif tip >= 2 && tip < 3:
		$Tips.text = ("Move berries using Mouse-1/left click")
	elif tip >= 3 && tip < 4:
		$Tips.text = ("Combine four berries in a line to make a line bomb")
	elif tip >= 4 && tip < 5:
		$Tips.text = ("Combine lines of berries at a right angle to make a cross bomb")
	elif tip >= 5 && tip < 6:
		$Tips.text = ("Combine 5 berries in a line to make a wild berry")
	elif tip >= 6 && tip < 7:
		$Tips.text = ("In timed mode, you have 5 minutes to try and beat the highscore")
	elif tip >= 7 && tip < 8:
		$Tips.text = ("'Ya like jazz?' - Barry B Benson")
	elif tip >= 8 && tip < 9:
		$Tips.text = ("'I don't like sand' - Anakin Skywalker")
	elif tip >= 9 && tip < 10:
		$Tips.text = ("'Never gonna give you up. Never gonna let you down' - Rick Astely")
	elif tip >= 10 && tip < 11:
		$Tips.text = ("If you notice a bug, no you didn't")

func _on_Timer_timeout():
	get_tree().change_scene("res://Main.tscn")
