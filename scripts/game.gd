class_name Game extends Node

@onready var current_level = null
@onready var mode_control = null
var currentControl = null

func _ready() -> void:
	Globals.game = $"."
	Globals.scoreboard = $Scoreboard
	show_starting_menu()
	
func on_endless_mode_button_pressed():
	load_endless_mode_level(Globals.levels[0])
	reset_scoreboard()
	
func on_about_button_pressed():
	load_level(Globals.about_level)
	hide_scoreboard()
	
func on_timed_mode_button_pressed():
	load_timed_level(Globals.levels[0])
	reset_scoreboard()
	
func on_timed_level_timeout():
	var score_report:ScoreReport = load("res://scenes/score_report.tscn").instantiate()
	add_child(score_report)
	var gamemode = "two_minute_hiscore"
	score_report.AddScore(str(Globals.scoreboard.score), gamemode)
	current_level.queue_free()
	mode_control.queue_free()
	current_level = score_report
	hide_scoreboard()
	score_report.get_node("Control/LoadMainMenuButton").connect("pressed", load_main_menu)
		
func load_endless_mode_level(level:String):
	load_level(level)

func load_timed_level(level: String):
	var timed_level = load("res://scenes/timed_level.tscn").instantiate()
	load_level(level)
	add_child(timed_level)
	mode_control = timed_level
	timed_level.timer.timeout.connect(on_timed_level_timeout)
	timed_level.timer.wait_time = 2 * Globals.MINUTES
	timed_level.timer.start()
	
func load_level(level: String):
	var nextLevel = load(level).instantiate()
	if(current_level != null):
		current_level.queue_free()
	current_level = nextLevel
	reset_scoreboard()
	add_child(current_level)

func hide_scoreboard():
	Globals.scoreboard.visible = false

func reset_scoreboard():
	Globals.scoreboard.reset()
	Globals.scoreboard.visible = true
	
func show_starting_menu():
	var starting_menu = load("res://scenes/menus/starting_menu.tscn").instantiate()
	starting_menu.get_node("Control/Menu/EndlessModeButton").connect("pressed", on_endless_mode_button_pressed)
	starting_menu.get_node("Control/Menu/AboutButton").connect("pressed", on_about_button_pressed)
	starting_menu.get_node("Control/Menu/TimedModeButton").connect("pressed", on_timed_mode_button_pressed)
	starting_menu.visible = true
	starting_menu.z_index = 1
	current_level = starting_menu
	add_child(starting_menu)
	
func load_main_menu():
	if(current_level != null):
		current_level.queue_free()
	hide_scoreboard()
	show_starting_menu()
	
