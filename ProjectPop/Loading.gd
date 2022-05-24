extends Node2D

var timer
var rng = RandomNumberGenerator.new()


func _ready():
	$AnimationPlayer.play("LOAD")
	$AudioStreamPlayer2D.play()
	rng.randomize()
	timer = get_node("Timer")
	var time = rng.randf_range(3.0, 15.0)
	$Timer.set_wait_time(time)
	$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Main.tscn")
