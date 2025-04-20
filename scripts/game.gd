class_name Game extends Node

@onready var currentLevel = null
var currentControl = null

func _ready() -> void:
	Globals.game = $"."
	Globals.scoreboard = $Scoreboard
	$Starting_Menu/Control/Menu/StartButton.connect("pressed", on_load_level_button_pressed)
	$Starting_Menu/Control/Menu/AboutButton.connect("pressed", on_about_button_pressed)
	
func on_load_level_button_pressed():
	#$Control.visible = false
	load_level(Globals.levels[0])
	show_scoreboard()
	
func on_about_button_pressed():
	load_level(Globals.about_level)
	hide_starting_menu()
	
func load_level(level: String):
	var nextLevel = load(level).instantiate()
	if(currentLevel != null):
		currentLevel.queue_free()
	currentLevel = nextLevel
	add_child(currentLevel)
	hide_starting_menu()

func show_scoreboard():
	Globals.scoreboard.reset()
	Globals.scoreboard.visible = true
	
func show_starting_menu():
	$Starting_Menu.visible = true
	
func hide_starting_menu():
	$Starting_Menu.visible = false
	
