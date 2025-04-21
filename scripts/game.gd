class_name Game extends Node

@onready var current_level = null
var currentControl = null

func _ready() -> void:
	Globals.game = $"."
	Globals.scoreboard = $Scoreboard
	$Starting_Menu/Control/Menu/EndlessModeButton.connect("pressed", on_endless_mode_button_pressed)
	$Starting_Menu/Control/Menu/AboutButton.connect("pressed", on_about_button_pressed)
	$Starting_Menu/Control/Menu/TimedModeButton.connect("pressed", on_timed_mode_button_pressed)
	
func on_endless_mode_button_pressed():
	load_endless_mode_level(Globals.levels[0])
	hide_starting_menu()
	show_scoreboard()
	
func on_about_button_pressed():
	load_level(Globals.about_level)
	hide_starting_menu()
	
func on_timed_mode_button_pressed():
	load_timed_level(Globals.levels[0])
	hide_starting_menu()
	show_scoreboard()
	
func on_timed_level_timeout():
	var score_report = load("res://scenes/score_report.tscn").instantiate()
	add_child(score_report)
	
	var score_label = score_report.get_node("Control/ScoreLabel")
	score_label.text = str(Globals.scoreboard.score)
	current_level.queue_free()
	Globals.scoreboard.visible = false
	
	
func load_endless_mode_level(level:String):
	load_level(level)

func load_timed_level(level: String):
	var timed_level = load("res://scenes/timed_level.tscn").instantiate()
	load_level(level)
	add_child(timed_level)
	timed_level.timer.timeout.connect(on_timed_level_timeout)
	timed_level.timer.wait_time = 10# * Globals.MINUTES
	timed_level.timer.start()
	
func load_level(level: String):
	var nextLevel = load(level).instantiate()
	if(current_level != null):
		current_level.queue_free()
	current_level = nextLevel
	add_child(current_level)

func show_scoreboard():
	Globals.scoreboard.reset()
	Globals.scoreboard.visible = true
	
func show_starting_menu():
	$Starting_Menu.visible = true
	
func hide_starting_menu():
	$Starting_Menu.visible = false
	
