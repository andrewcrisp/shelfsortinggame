extends Node2D

signal item_placed(spot)
signal item_removed(spot)
signal spot_scored(points)

var heldItem = null
var scoreboard = null

func _ready() -> void:
	scoreboard = get_tree().get_root().get_node("Level").get_node("Score")

func _process(delta: float) -> void:
	if ! heldItem == null:
		heldItem.global_position = global_position

func hold_item(item):
	heldItem = item
	item.lastArea = $Area2D
	item_placed.emit($".")

func isHoldingItem():
	return heldItem != null
	
func remove_item():
	heldItem = null
	item_removed.emit($".")
	
func score_item():
	heldItem.queue_free()
	remove_item()
	scoreboard.score_item(1)
