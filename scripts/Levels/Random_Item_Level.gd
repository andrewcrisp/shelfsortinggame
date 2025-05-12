class_name Random_Item_Level extends Level

func _ready() -> void:
	Globals.itemSpawner = $item_spawner
	Globals.current_level = $"."
	myScoreboard = $Scoreboard
	get_tree().call_group("shelves", "spawnContents")
