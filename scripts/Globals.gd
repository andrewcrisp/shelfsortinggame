extends Node

var game: Game
var scoreboard: Scoreboard
var itemSpawner: Item_Spawner

var z_levels = {
	"background" = 0,
	"held_item" = 1000,
	"placed_item" = 500
}

var groceries = []
var levels = []


func _ready() -> void:
	populate_levels()
	populate_groceries()
	
func populate_levels():
	levels.append("res://scenes/levels/1/level.tscn")
	
func populate_groceries():
	groceries.append("res://scenes/groceries/sunflower.tscn")
	groceries.append("res://scenes/groceries/wheat.tscn")
	groceries.append("res://scenes/groceries/turnip.tscn")
	groceries.append("res://scenes/groceries/wheat_packet.tscn")
	groceries.append("res://scenes/groceries/turnip_packet.tscn")
