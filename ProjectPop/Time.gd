extends Label


func _ready():
	$game_timer.start()

func _process(delta):
	$Time.text = str($game_time.time_left)
