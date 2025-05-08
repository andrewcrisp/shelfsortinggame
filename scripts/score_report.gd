class_name ScoreReport extends Node2D
var dateFormat = "%s/%s/%s %s:%s" #4/25/2025 13:00:00

func _ready():
	pass


func AddScore(score:String, gamemode:String):
	$Frame/ScoreLabel.text = str(score)
	var newScore:ScoreEntry = load("res://scenes/components/score_entry.tscn").instantiate()
	newScore.gameMode = gamemode
	var dateScored := Time.get_datetime_dict_from_system()
	newScore.dateScored = dateFormat % [
		dateScored["month"], 
		dateScored["day"],
		dateScored["year"],
		dateScored["hour"],
		dateScored["minute"]
		]
	newScore.score = int(score)
	$Frame/HighScoreViewer.hiscores.append(newScore)
	$Frame/HighScoreViewer.populateScoresList(gamemode)
	$Frame/HighScoreViewer.saveScoresList()
	#$Control/HighScoreViewer
	
