class_name Scoreboard extends Control

var score = 0

func _ready() -> void:
	score = 0
	
func _process(_delta: float) -> void:
	$RichTextLabel.text = str(score)
	
func score_item(points):
	score += points

func reset():
	score = 0
