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
	tip = tip_num.randf_range(1, 3)
	tips()

func tips():
	if tip < 2:
		$Tips.text = ("Press 'Escape' to return to the menu")
	elif tip >= 2:
		$Tips.text = ("Move berries using Mouse-1/left click")

func _on_Timer_timeout():
	get_tree().change_scene("res://Main.tscn")
