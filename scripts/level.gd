extends Node2D

signal score(points)

var item_spawner: Item_Spawner

var carriedItem = null

func _ready() -> void:
	item_spawner = $item_spawner
	$Conveyor.item_spawner = item_spawner
	connect("score", _on_shelf_score)

func drop_item():
	carriedItem = null
	
func hold_item(item):
	carriedItem = item

func _on_shelf_score(points: Variant) -> void:
	score.emit(points)
