class_name ScoreEntry extends Control

var gameMode:String = "Game Mode"
var dateScored:String = "Date"
var score:int = 0

func _ready() -> void:
	$HBoxContainer/GameModeLabel.text = gameMode
	$HBoxContainer/DateLabel.text = dateScored
	$HBoxContainer/ScoreLabel.text = str(score).pad_decimals(0)

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"gameMode" : gameMode,
		"dateScored" : dateScored,
		"score" : str(score)
	}
	return save_dict
