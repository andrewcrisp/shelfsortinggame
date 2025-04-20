class_name Game extends Node

var currentLevel = null
var currentControl = null

func _ready() -> void:
	Globals.game = $"."
	Globals.scoreboard = $Scoreboard
	$Control/Menu/StartButton.connect("pressed", on_load_level_button_pressed)
	$Control/Menu/AboutButton.connect("pressed", on_about_button_pressed)
	
func on_load_level_button_pressed():
	$Control/Menu/StartButton.visible = false
	load_level(Globals.levels[0])
	show_scoreboard()
	
func on_about_button_pressed():
	load_level(Globals.about_level)
	
func load_level(level: String):
	var nextLevel = load(level).instantiate()
	currentLevel = nextLevel
	$Node2D.add_child(currentLevel)

func show_scoreboard():
	Globals.scoreboard.reset()
	Globals.scoreboard.visible = true
	
