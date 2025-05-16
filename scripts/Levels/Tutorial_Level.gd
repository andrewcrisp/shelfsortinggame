class_name Tutorial_Level extends Level

var hand
var hand_position_over_item = Vector2(30,100)
var spot

var last_move_complete = 0
var current_move = 0
var tutorial_moves:Array


func _ready() -> void:
	Globals.itemSpawner = $item_spawner
	Globals.current_level = $"."
	myScoreboard = $Scoreboard
	$Shelves/Shelf3.remove_from_group("shelves")
	$Shelves/Shelf7.remove_from_group("shelves")
	$Shelves/Shelf8.remove_from_group("shelves")
	#get_tree().call_group("shelves", "spawnContents")
	
	spot = $Shelves/Shelf3/Spot3
	load_tutorial_shelves()
	
	tutorial_moves.append(move_one)
	tutorial_moves.append(move_two)

func _process(delta: float) -> void:
	if ((current_move == last_move_complete) 
	&& (last_move_complete < len(tutorial_moves))):
		current_move += 1
		## Off by one error in indexing
		tutorial_moves[current_move-1].call()

func move_one():
	animate_move($Shelves/Shelf3/Spot3, $Shelves/Shelf8/Spot3, move_one_callback)

func move_two():
	animate_move($Shelves/Shelf7/Spot1, $Shelves/Shelf8/Spot1, move_two_callback)

func get_tutorial_item(itemNumber:int):
	var item:SortableItem = $item_spawner.SpawnNewItemFromTextureList(itemNumber)
	item.set_script(load("res://scripts/tutorial_item.gd"))
	return item
	
func load_tutorial_shelves():
	$Shelves/Shelf3/Spot1.hold_item_in_background(get_tutorial_item(1))
	$Shelves/Shelf3/Spot3.hold_item(get_tutorial_item(0))
	
	$Shelves/Shelf8/Spot2.hold_item(get_tutorial_item(0))
	$Shelves/Shelf8/Spot3.hold_item_in_background(get_tutorial_item(1))
	
	$Shelves/Shelf7/Spot1.hold_item(get_tutorial_item(0))
	$Shelves/Shelf7/Spot3.hold_item(get_tutorial_item(1))
	
func complete_move():
	last_move_complete += 1
	
func move_one_callback():
	var ItemToMove : Tutorial_Item = $Shelves/Shelf3/Spot3.heldItem
	ItemToMove.ready_to_use = true
	ItemToMove.set_grabbable(true)
	ItemToMove.set_drop_target($Shelves/Shelf8/Spot3/Area2D)
	ItemToMove.z_index = Globals.z_levels["placed_item"]
	$Shelves/Shelf8/Spot3.backItem.z_index = Globals.z_levels["back_item"]
	
func move_two_callback():
	$Shelves/Shelf7/Spot1.heldItem.set_grabbable(true)
	$Shelves/Shelf7/Spot1.heldItem.set_drop_target($Shelves/Shelf8/Spot1/Area2D)
	
func animate_move(spot_from, spot_to, myCallback:Callable):
	var tween = create_tween()
	tween.tween_property($Hand, "position", (spot_from.global_position - hand_position_over_item), 1)
	for i in 3:
		tween.tween_property($Hand, "visible", true, 0)
		tween.tween_property($Hand, "position", spot_from.global_position, .2)
		tween.tween_property($Hand, "position", spot_to.global_position, 1)
		tween.tween_property($Hand, "position", spot_to.global_position - hand_position_over_item, .2)
		tween.tween_property($Hand, "visible", false, 0)
		tween.tween_property($Hand, "position", (spot_from.global_position - hand_position_over_item), .2)
	tween.tween_callback(myCallback)
