class_name scoreboard extends Node2D

func _process(_delta: float) -> void:
	$Label.text = str(Globals.score.score)

func bounce_scoreboard():
	var tween = create_tween().set_loops(3)
	tween.tween_property($Sprite2D, "position:y", -20, .1)
	tween.tween_property($Sprite2D, "position:y", 20, .1)
