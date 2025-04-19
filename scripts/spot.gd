class_name Spot extends Node2D

signal item_placed(spot)
signal item_removed(spot)

const HELD_ITEM_Z = 10
const BACK_ITEM_Z = 5
const BACK_ITEM_POSITION = Vector2(-4,2)
var heldItem : SortableItem = null
var backItem : SortableItem = null
var points = 1

func _process(_delta: float) -> void:
	if ! heldItem == null:
		heldItem.global_position = global_position
	if ! backItem == null:
		backItem.global_position = global_position + BACK_ITEM_POSITION

func hold_item_in_background(item: SortableItem):
	if (item != null):
		backItem = item
		item.z_index = BACK_ITEM_Z
		item.isGrabbable = false
		item.position = BACK_ITEM_POSITION
		#item.scale = item.scale * .9
		item.modulate = Color(.1,.1,.1,.4)
		

func hold_item(item: SortableItem):
	if (item != null):
		heldItem = item
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
	
