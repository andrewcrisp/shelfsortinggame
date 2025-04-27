class_name ScoreEntry extends Control

var gameMode:String = "Game Mode"
var dateScored:String = "Date"
var score:String = "Score"

func _ready() -> void:
	$HBoxContainer/GameModeLabel.text = gameMode
	
	$HBoxContainer/DateLabel.text = dateScored
	$HBoxContainer/ScoreLabel.text = score	
