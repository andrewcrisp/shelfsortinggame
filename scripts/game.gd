class_name Game extends Node

var currentLevel = null
var currentControl = null

func _ready() -> void:
	Globals.game = $"."
	Globals.scoreboard = $Control/Scoreboard
	load_level(Globals.levels[0])
	
func load_level(level: String):
	var nextLevel = load(level).instantiate()
	currentLevel = nextLevel
	add_child(currentLevel)
	Globals.scoreboard.reset()
	Globals.scoreboard.visible = true
