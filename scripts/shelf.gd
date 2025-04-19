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
	
	add_to_group("shelves")
	
	
func _on_spot_item_placed(_spot: Variant) -> void:
	numItemsHeld += 1
	doCheckForScore()

func _on_spot_item_removed(_spot: Variant) -> void:
	numItemsHeld -= 1

func doCheckForScore():
	#print($spot1.heldItem.get_groups())
	if ($Spot1.isHoldingItem()
	&& $Spot2.isHoldingItem()
	&& $Spot3.isHoldingItem()
	&& $Spot1.heldItem.type == $Spot2.heldItem.type
	&& $Spot1.heldItem.type == $Spot3.heldItem.type
	):
		$Spot1.score_item()
		$Spot2.score_item()
		$Spot3.score_item()
		spawnContents()

func spawnContents():
	var newItem = Globals.itemSpawner.SpawnNewItem()
	$Spot1.hold_item(newItem)
	newItem = Globals.itemSpawner.SpawnNewItem()
	$Spot2.hold_item(newItem)
	newItem = Globals.itemSpawner.SpawnNewItem()
	while (newItem == $Spot1.heldItem
		&& newItem == $Spot2.heldItem):
		newItem = Globals.itemSpawner.SpawnNewItem()
	$Spot3.hold_item(newItem)

	
	if $Spot1.backItem == null:
		newItem = Globals.itemSpawner.SpawnNewItem()
		$Spot1.hold_item_in_background(newItem)
	if $Spot2.backItem == null:
			newItem = Globals.itemSpawner.SpawnNewItem()
			$Spot2.hold_item_in_background(newItem)
	if $Spot3.backItem == null:
		newItem = Globals.itemSpawner.SpawnNewItem()
		while (newItem == $Spot1.backItem
			&& newItem == $Spot2.backItem):
			newItem = Globals.itemSpawner.SpawnNewItem()
		$Spot3.hold_item_in_background(newItem)

func _on_spot_scored(points: Variant) -> void:
	score.emit(points)
