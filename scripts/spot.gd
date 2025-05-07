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
		item.lastArea = null
		item.z_index = BACK_ITEM_Z
		item.isGrabbable = false
		item.position = BACK_ITEM_POSITION
		item.use_background_shader()
		
func hold_item(item: SortableItem):
	if (item != null):
		heldItem = item
		if (item.lastArea != null):
			item.lastArea.remove_item()
		item.lastArea = $"."
		item.global_rotation = 0
		item.z_index = HELD_ITEM_Z
		#item.use_carried_item_shader()
		item_placed.emit($".")

func move_item_forward():
	if (!isHoldingItem()):
		if (isHoldingBackItem()):
			var item = backItem
			heldItem = item
			if (item.lastArea != null):
				item.lastArea.remove_item()
			item.lastArea = $"."
			item.global_rotation = 0
			item.z_index = HELD_ITEM_Z
			remove_back_item()
			item.z_index = HELD_ITEM_Z
			item.isGrabbable = true
			item.position = Vector2.ZERO
			item.mySprite.material.shader = Globals.carried_item_shader
			item.get_node("Sprite2D").scale = Vector2(1,1)
	
func isHoldingItem():
	return heldItem != null
	
func isHoldingBackItem():
	return backItem != null
	
func remove_item():
	heldItem = null
	item_removed.emit($".")

func remove_back_item():
	backItem = null

func score_item():
	heldItem.send_to_scoreboard()
	heldItem = null
	Globals.score.score_item(points)
	
