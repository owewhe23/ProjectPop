extends Label

var score = 0

func _ready():
	pass 

func scored():
	score = score + 100
	text = "Score: %s" % score

func scored_row_col():
	score = score + 50
	text = "Score: %s" % score

func scored_adj():
	score = score + 75
	text = "Score: %s" % score
