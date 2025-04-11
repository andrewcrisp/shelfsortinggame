extends Node2D

var spot

var maxSpots: int = 3
var spots: Array
var spawner = null
var item_spawner
var velocity = 100

func _process(delta: float) -> void:
	$Path2D/PathFollow2D.h_offset += velocity * delta	
	if spots.is_empty():
		SpawnSpot()

func _ready() -> void:
	spot = preload("res://scenes/spot.tscn")
	var curve:Curve2D = $Path2D.curve
	$spawner.position = curve.get_point_position(0)
	$despawner.position = curve.get_point_position(1)
	item_spawner = get_tree().get_root().get_node("Level").get_node("item_spawner")
	
	
func SpawnSpot():
	var newspot = spot.instantiate()
	newspot.scale = Vector2(4,4)
	
	$despawner.connect("area_entered", _on_despawner_entered)
	$Path2D/PathFollow2D.add_child(newspot)
	newspot.position = $spawner.position
	print("new spot at position " + str(newspot.global_position))
	spots.append(newspot)

func _on_despawner_entered(area: Area2D):
	var spot = area.get_parent()
	spot.global_position = $spawner.global_position
	if spot.heldItem == null:
		var item = item_spawner.SpawnNewItem()
		item.position = spot.global_position
		spot.hold_item(item)
