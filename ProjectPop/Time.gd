extends Label


func _ready():
	pass

func start():
	$game_timer.start()

func _process(delta):
	text = str("Time: ", round($game_timer.time_left))

