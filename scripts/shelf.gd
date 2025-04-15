extends Node2D

signal score(points)

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
	doCheckForScore()

func _on_spot_item_removed(spot: Variant) -> void:
	numItemsHeld -= 1
	print("removing item. " + str(numItemsHeld) + " items")

func doCheckForScore():
	#print($spot1.heldItem.get_groups())
	if ($Spot1.isHoldingItem()
	&& $Spot2.isHoldingItem()
	&& $Spot3.isHoldingItem()
	&& $Spot1.heldItem.type == $Spot2.heldItem.type
	&& $Spot1.heldItem.type == $Spot3.heldItem.type
	):
		
		print("SCORE")
		$Spot1.score_item()
		$Spot2.score_item()
		$Spot3.score_item()


func _on_spot_scored(points: Variant) -> void:
	score.emit(points)
