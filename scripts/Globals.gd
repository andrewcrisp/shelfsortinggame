extends Node

const MINUTES: int = 60

var game: Game
var score: Score
var itemSpawner: Item_Spawner
var current_level
var carried_item_shader
var background_item_shader
var tutorial_level

var gamemodes = {
	"two_minute_timed" = "res://scenes/modes/timed_level.tscn",
	"endless" = "res://scenes/modes/endless_mode.tscn",
	"arcade" = "res://scenes/modes/arcade.tscn",
	"tutorial" = "res://scenes/modes/tutorial_mode.tscn"
}

var z_levels = {
	"background" = 0,
	"held_item" = 1000,
	"placed_item" = 500
}

var groceries = []
var levels = []
var about_level = "res://scenes/levels/special/about.tscn"
var starting_menu_level = "res://scenes/menus/starting_menu.tscn"

func _ready() -> void:
	populate_levels()
	populate_groceries()
	carried_item_shader = load("res://scripts/shaders/outline.gdshader")
	background_item_shader = load("res://scripts/shaders/background_item.gdshader")
	
func populate_levels():
	levels.append("res://scenes/levels/1/1.tscn")
	tutorial_level = "res://scenes/levels/special/Tutorial.tscn"
	
func populate_groceries():
	groceries.append("res://scenes/groceries/sunflower.tscn")
	groceries.append("res://scenes/groceries/wheat.tscn")
	groceries.append("res://scenes/groceries/turnip.tscn")
	groceries.append("res://scenes/groceries/wheat_packet.tscn")
	groceries.append("res://scenes/groceries/turnip_packet.tscn")
