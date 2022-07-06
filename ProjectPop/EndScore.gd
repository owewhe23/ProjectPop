extends Node2D

var save_data = {
	"score": 0,
	}


func _ready():
	if global.endscore > save_data.score:
		save_data.score = global.endscore
		save()
	save_data
	endscore()

func endscore():
	$Score_n.text = ("%s" % global.endscore)
	$Highscore_n.text = ("%s" % save_data.score)
	

func save():
	var cfgFile = File.new()
	cfgFile.open("user://save.cfg", File.WRITE)
	cfgFile.store_line(to_json(save_data))
	cfgFile.close()

func load():
	var cfgFile = File.new()
	if not cfgFile.fileExists("user://save.cfg", File.READ):
		save()
		return
	cfgFile.open("user://save.cfg", File.READ)
	var data = parse_json(cfgFile.get_as_text())
	
	save_data.score = data.score


#https://godotengine.org/qa/95533/i-want-to-save-my-score-but-i-dont-know-how-to-do-it
