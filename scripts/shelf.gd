extends Node2D

var numItemsHeld = 0

func _on_spot_item_held(spot: Variant) -> void:
	numItemsHeld += 1
	print("holding " + str(numItemsHeld) + " items")

func _on_spot_item_dropped(spot: Variant) -> void:
	numItemsHeld -= 1
	print("removing item. " + str(numItemsHeld) + " items")
