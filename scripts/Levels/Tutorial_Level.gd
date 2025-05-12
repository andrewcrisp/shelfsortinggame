class_name Tutorial_Level extends Level

func _ready() -> void:
	Globals.itemSpawner = $item_spawner
	Globals.current_level = $"."
	myScoreboard = $Scoreboard
	$Shelves/Shelf3.remove_from_group("shelves")
	$Shelves/Shelf7.remove_from_group("shelves")
	$Shelves/Shelf8.remove_from_group("shelves")
	get_tree().call_group("shelves", "spawnContents")
	
	$Shelves/Shelf3/Spot3.hold_item($item_spawner.SpawnNewItemFromTextureList(0))
	$Shelves/Shelf3/Spot1.hold_item_in_background($item_spawner.SpawnNewItemFromTextureList(1))
	
	$Shelves/Shelf8/Spot2.hold_item($item_spawner.SpawnNewItemFromTextureList(0))
	$Shelves/Shelf8/Spot3.hold_item_in_background($item_spawner.SpawnNewItemFromTextureList(1))
	
	$Shelves/Shelf7/Spot1.hold_item($item_spawner.SpawnNewItemFromTextureList(0))
	$Shelves/Shelf7/Spot2.hold_item(null)
	$Shelves/Shelf7/Spot3.hold_item($item_spawner.SpawnNewItemFromTextureList(1))
	
	
	
