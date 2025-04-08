extends Node2D

signal item_placed(spot)
signal item_removed(spot)

var heldItem = null

func _process(delta: float) -> void:
	if ! heldItem == null:
		heldItem.global_position = global_position

func hold_item(item):
	heldItem = item
	item_placed.emit($".")
	
func remove_item():
	heldItem = null
	item_removed.emit($".")
