class_name Spot extends Node2D

signal item_placed(spot)
signal item_removed(spot)

const HELD_ITEM_Z = 10
const BACK_ITEM_Z = 5

var heldItem = null
var backItem = null
var points = 1

func _process(_delta: float) -> void:
	if ! heldItem == null:
		heldItem.global_position = global_position

func hold_item_in_background(item: SortableItem):
	if (item != null):
		backItem = item
		add_child(item)
		item.global_rotation = 0
		item.z_index = BACK_ITEM_Z
		item.isGrabbable = false
		item.position = Vector2(-4,2)
		item.scale = item.scale * .9
		

func hold_item(item: SortableItem):
	if (item != null):
		heldItem = item
		add_child(item)
		item.global_rotation = 0
		item.z_index = HELD_ITEM_Z
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
	
