extends Node2D

var numItemsHeld = 0

func _ready() -> void:
	$Spot1.connect("item_placed", _on_spot_item_placed)
	$Spot1.connect("item_removed", _on_spot_item_removed)
	
	$Spot2.connect("item_placed", _on_spot_item_placed)
	$Spot2.connect("item_removed", _on_spot_item_removed)
	
	$Spot3.connect("item_placed", _on_spot_item_placed)
	$Spot3.connect("item_removed", _on_spot_item_removed)
	
func _on_spot_item_placed(spot: Variant) -> void:
	numItemsHeld += 1
	print("holding " + str(numItemsHeld) + " items")

func _on_spot_item_removed(spot: Variant) -> void:
	numItemsHeld -= 1
	print("removing item. " + str(numItemsHeld) + " items")
