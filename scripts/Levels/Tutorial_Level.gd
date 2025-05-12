class_name Tutorial_Level extends Level

var hand
var hand_position_over_item = Vector2(30,100)

func _ready() -> void:
	Globals.itemSpawner = $item_spawner
	Globals.current_level = $"."
	myScoreboard = $Scoreboard
	$Shelves/Shelf3.remove_from_group("shelves")
	$Shelves/Shelf7.remove_from_group("shelves")
	$Shelves/Shelf8.remove_from_group("shelves")
	#get_tree().call_group("shelves", "spawnContents")
	load_tutorial_shelves()
	hand = $Hand
	animate_move_one($Shelves/Shelf3/Spot3, $Shelves/Shelf8/Spot3)
	
func load_tutorial_shelves():
	$Shelves/Shelf3/Spot3.hold_item($item_spawner.SpawnNewItemFromTextureList(0))
	$Shelves/Shelf3/Spot1.hold_item_in_background($item_spawner.SpawnNewItemFromTextureList(1))
	
	$Shelves/Shelf8/Spot2.hold_item($item_spawner.SpawnNewItemFromTextureList(0))
	$Shelves/Shelf8/Spot3.hold_item_in_background($item_spawner.SpawnNewItemFromTextureList(1))
	
	$Shelves/Shelf7/Spot1.hold_item($item_spawner.SpawnNewItemFromTextureList(0))
	$Shelves/Shelf7/Spot2.hold_item(null)
	$Shelves/Shelf7/Spot3.hold_item($item_spawner.SpawnNewItemFromTextureList(1))
	
	
func animate_move_one(spot_from, spot_to):
	var tween = create_tween()
	tween.tween_property($Hand, "position", (spot_from.global_position - hand_position_over_item), 1)
	for i in 3:
		tween.tween_property($Hand, "visible", true, 0)
		tween.tween_property($Hand, "position", spot_from.global_position, .2)
		tween.tween_property($Hand, "position", spot_to.global_position, 1)
		tween.tween_property($Hand, "position", spot_to.global_position - hand_position_over_item, .2)
		tween.tween_property($Hand, "visible", false, 0)
		tween.tween_property($Hand, "position", (spot_from.global_position - hand_position_over_item), .2)
		
	tween.tween_callback(hide_hand)

func hide_hand():
	$Hand.visible = false
