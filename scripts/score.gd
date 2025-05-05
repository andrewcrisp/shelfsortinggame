class_name Score extends Control

var score = 0

func _ready() -> void:
	score = 0
	
func score_item(points):
	score += points

func reset():
	score = 0
