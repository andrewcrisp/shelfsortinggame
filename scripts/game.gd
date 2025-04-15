class_name Game extends Node

var currentLevel = null
var currentControl = null

func _ready() -> void:
	Globals.game = $"."
	Globals.scoreboard = $Control/Scoreboard
	$Control/Menu/StartButton.connect("pressed", on_load_level_button_pressed)
	
	#load_level(Globals.levels[0])
	
func on_load_level_button_pressed():
	$Control/Menu/StartButton.visible = false
	load_level(Globals.levels[0])
	
func load_level(level: String):
	var nextLevel = load(level).instantiate()
	currentLevel = nextLevel
	add_child(currentLevel)
	Globals.scoreboard.reset()
	Globals.scoreboard.visible = true
