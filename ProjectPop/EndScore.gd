extends Node2D



func _ready():
	endscore() 

func endscore():
	$Score_n.text = ("%s" % global.endscore)
	
