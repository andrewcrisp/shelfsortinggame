class_name Game extends Node


@onready var mode_control = null
var currentControl = null
@onready var selected_level = Globals.levels[0]
var gamemode

func _ready() -> void:
	Globals.game = $"."
	Globals.score = $Score
	show_starting_menu()
	
func on_endless_mode_button_pressed():
	load_endless_mode_level(selected_level)
	reset_scoreboard()
	
func on_about_button_pressed():
	load_level(Globals.about_level)

func on_arcade_button_pressed():
	load_arcade_mode_level(selected_level)
	reset_scoreboard()

func on_quit_button_pressed():
	show_score_report_after_level()	

func on_timed_mode_button_pressed():
	load_timed_level(selected_level)
	reset_scoreboard()
	
func on_tutorial_button_pressed():
	load_tutorial(Globals.tutorial_level)
	reset_scoreboard()	
	
func on_timed_level_timeout():
	show_score_report_after_level()
	
func show_score_report_after_level():
	var score_report:ScoreReport = load("res://scenes/levels/special/score_report.tscn").instantiate()
	add_child(score_report)
	score_report.AddScore(str(Globals.score.score), gamemode)
	Globals.current_level.queue_free()
	mode_control.queue_free()
	Globals.current_level = score_report
	score_report.get_node("BackButton").connect("clicked", load_main_menu)
	
func load_arcade_mode_level(level:String):
	var gameMode = load(Globals.gamemodes["arcade"]).instantiate()
	load_level(level)
	add_child(gameMode)
	gamemode = "arcade"
	mode_control = gameMode
	gameMode.timer.timeout.connect(on_timed_level_timeout)
	gameMode.timer.wait_time = 2 * Globals.MINUTES
	gameMode.timer.start()
	
func load_endless_mode_level(level:String):
	var gameMode = load(Globals.gamemodes["endless"]).instantiate()
	load_level(level)
	add_child(gameMode)
	gamemode = "endless"
	mode_control = gameMode
	gameMode.get_node("Control/QuitButton").connect("pressed", on_quit_button_pressed)

func load_timed_level(level: String):
	var gameMode = load(Globals.gamemodes["two_minute_timed"]).instantiate()
	load_level(level)
	add_child(gameMode)
	gamemode = "two_minute_hiscore"
	mode_control = gameMode
	gameMode.timer.timeout.connect(on_timed_level_timeout)
	gameMode.timer.wait_time = 2 * Globals.MINUTES
	gameMode.timer.start()

func load_tutorial(level: String):
	var gameMode = load(Globals.gamemodes["tutorial"]).instantiate()
	load_level(level)
	add_child(gameMode)
	gamemode = "two_minute_hiscore"
	mode_control = gameMode
	gameMode.timer.timeout.connect(on_timed_level_timeout)
	gameMode.timer.wait_time = 2 * Globals.MINUTES
	gameMode.timer.start()

func load_level(level: String):
	var nextLevel = load(level).instantiate()
	if(Globals.current_level != null):
		Globals.current_level.queue_free()
	Globals.current_level = nextLevel
	reset_scoreboard()
	add_child(nextLevel)
	$Background.visible = false
	$TitleBanner.visible = false

func reset_scoreboard():
	Globals.score.reset()
	
func show_starting_menu():
	var starting_menu = load("res://scenes/menus/starting_menu.tscn").instantiate()
	starting_menu.get_node("Control/Menu/EndlessModeButton").connect("pressed", on_endless_mode_button_pressed)
	starting_menu.get_node("Control/Menu/TimedModeButton").connect("pressed", on_timed_mode_button_pressed)
	starting_menu.get_node("Control/Menu/ArcadeModeButton").connect("pressed", on_arcade_button_pressed)
	starting_menu.get_node("Control/Menu/TutorialButton").connect("pressed", on_tutorial_button_pressed)
	starting_menu.get_node("Control/Menu/AboutButton").connect("pressed", on_about_button_pressed)
	starting_menu.visible = true
	starting_menu.z_index = 1
	add_child(starting_menu)
	$Background.visible = true
	$TitleBanner.visible = true
	gamemode = null
	
func load_main_menu():
	if(Globals.current_level != null):
		Globals.current_level.queue_free()
	show_starting_menu()
	
