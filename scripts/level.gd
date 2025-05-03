extends Node2D

signal score(points)

var carriedItem = null
var myScoreboard: scoreboard

func _ready() -> void:
	Globals.itemSpawner = $item_spawner
	Globals.current_level = $"."
	myScoreboard = $Scoreboard
	connect("score", _on_shelf_score)
	get_tree().call_group("shelves", "spawnContents")
	
func drop_item():
	carriedItem = null
	
func hold_item(item):
	carriedItem = item

func _on_shelf_score(points: Variant) -> void:
	score.emit(points)
