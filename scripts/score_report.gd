class_name ScoreReport extends Node2D

func _ready():
	var viewportSize = get_viewport().get_visible_rect().size
	$Control.size = viewportSize
	AddScore("25", "mygame")

func AddScore(score:String, gamemode:String):
	$Control/ScoreLabel.text = str(score)
	var newScore:ScoreEntry = load("res://scenes/score_entry.tscn").instantiate()
	newScore.gameMode = gamemode
	newScore.dateScored = Time.get_datetime_string_from_system()
	newScore.score = score
	$Control/HighScoreViewer.hiscores.append(newScore)
	$Control/HighScoreViewer.populateScoresList()
	
	#$Control/HighScoreViewer
	
