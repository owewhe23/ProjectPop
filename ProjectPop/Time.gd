extends Label


func _ready():
	pass

func _process(delta):
	text = str("Time: ", round($game_timer.time_left))

