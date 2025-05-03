class_name Game extends Node


@onready var mode_control = null
var currentControl = null

func _ready() -> void:
	Globals.game = $"."
	Globals.score = $Score
	show_starting_menu()
	
func on_endless_mode_button_pressed():
	load_endless_mode_level(Globals.levels[0])
	reset_scoreboard()
	
func on_about_button_pressed():
	load_level(Globals.about_level)

func on_quit_button_pressed():
	var gamemode = "endless"
	show_score_report_after_level(gamemode)	

func on_timed_mode_button_pressed():
	load_timed_level(Globals.levels[0])
	reset_scoreboard()
	
func on_timed_level_timeout():
	var gamemode = "two_minute_hiscore"
	show_score_report_after_level(gamemode)
	
func show_score_report_after_level(gamemode):
	var score_report:ScoreReport = load("res://scenes/levels/special/score_report.tscn").instantiate()
	add_child(score_report)
	score_report.AddScore(str(Globals.score.score), gamemode)
	Globals.current_level.queue_free()
	mode_control.queue_free()
	Globals.current_level = score_report
	score_report.get_node("Control/LoadMainMenuButton").connect("pressed", load_main_menu)
	
func load_endless_mode_level(level:String):
	var gameMode = load(Globals.gamemodes["endless"]).instantiate()
	load_level(level)
	add_child(gameMode)
	mode_control = gameMode
	gameMode.get_node("Control/QuitButton").connect("pressed", on_quit_button_pressed)

func load_timed_level(level: String):
	var timed_level = load(Globals.gamemodes["two_minute_timed"]).instantiate()
	load_level(level)
	add_child(timed_level)
	mode_control = timed_level
	timed_level.timer.timeout.connect(on_timed_level_timeout)
	timed_level.timer.wait_time = 2 * Globals.MINUTES
	timed_level.timer.start()
	
func load_level(level: String):
	var nextLevel = load(level).instantiate()
	if(Globals.current_level != null):
		Globals.current_level.queue_free()
	reset_scoreboard()
	add_child(nextLevel)
	$Background.visible = false
	$StartScreen.visible = false

func reset_scoreboard():
	Globals.score.reset()
	
func show_starting_menu():
	var starting_menu = load("res://scenes/menus/starting_menu.tscn").instantiate()
	starting_menu.get_node("Control/Menu/EndlessModeButton").connect("pressed", on_endless_mode_button_pressed)
	starting_menu.get_node("Control/Menu/AboutButton").connect("pressed", on_about_button_pressed)
	starting_menu.get_node("Control/Menu/TimedModeButton").connect("pressed", on_timed_mode_button_pressed)
	starting_menu.visible = true
	starting_menu.z_index = 1
	add_child(starting_menu)
	$Background.visible = true
	$StartScreen.visible = true
	
func load_main_menu():
	if(Globals.current_level != null):
		Globals.current_level.queue_free()
	show_starting_menu()
	
