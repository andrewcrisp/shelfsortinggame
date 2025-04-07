extends Node2D

signal item_held(spot)
signal item_dropped(spot)

var heldItem = null

func _process(delta: float) -> void:
	if ! heldItem == null:
		heldItem.global_position = global_position

func hold_item(item):
	heldItem = item
	item_held.emit($".")
	
func remove_item():
	heldItem = null
	item_dropped.emit($".")
