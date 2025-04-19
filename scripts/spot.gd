class_name Spot extends Node2D

signal item_placed(spot)
signal item_removed(spot)

var heldItem = null
var scoreboard = null
var points = 1

func _process(_delta: float) -> void:
	if ! heldItem == null:
		heldItem.global_position = global_position

func hold_item(item):
	if (item != null):
		heldItem = item
		item.lastArea = $Area2D
		item_placed.emit($".")

func isHoldingItem():
	return heldItem != null
	
func remove_item():
	heldItem = null
	item_removed.emit($".")
	
func score_item():
	heldItem.send_to_scoreboard()
	remove_item()
	Globals.scoreboard.score_item(points)
