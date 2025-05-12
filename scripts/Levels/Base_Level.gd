class_name Level extends Node2D

signal score(points)
var carriedItem = null
var myScoreboard: scoreboard

func drop_item():
	carriedItem = null
	
func hold_item(item):
	carriedItem = item

func _on_shelf_score(points: Variant) -> void:
	score.emit(points)
