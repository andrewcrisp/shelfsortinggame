class_name scoreboard extends Node2D

func _process(_delta: float) -> void:
	$Label.text = str(Globals.score.score)
