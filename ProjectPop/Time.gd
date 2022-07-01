extends Label


func _ready():
	pass

func start():
	$game_timer.start()
	global.timed = false

func _process(delta):
	text = str("Time: ", round($game_timer.time_left))

