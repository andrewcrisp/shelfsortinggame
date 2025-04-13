extends Node2D

var maxSpots: int = 3
var spots: Array
var spawner = null
var item_spawner
var velocity = 50 #100

func _process(delta: float) -> void:
	$Path2D/PathFollow2D.h_offset += velocity * delta
	$Path2D/PathFollow2D2.h_offset += velocity * delta
	$Path2D/PathFollow2D3.h_offset += velocity * delta

func _ready() -> void:
	var curve:Curve2D = $Path2D.curve
	$spawner.position = curve.get_point_position(0)
	$despawner.position = curve.get_point_position(1)
	$despawner.connect("area_entered", _on_despawner_entered)
	item_spawner = get_tree().get_root().get_node("Level").get_node("item_spawner")
	var curveLength = curve.get_baked_length()
	$Path2D/PathFollow2D.h_offset = curveLength / (maxSpots) * 0
	$Path2D/PathFollow2D2.h_offset = curveLength / (maxSpots) * 1
	$Path2D/PathFollow2D3.h_offset = curveLength / (maxSpots) * 2
	
	#SpawnSpot()
	
func _on_despawner_entered(area: Area2D):
	var spot = area.get_parent()
	spot.global_position = $spawner.global_position
	#addItem(spot)
	
func addItem(spot):
	if spot.heldItem == null:
		var item = item_spawner.SpawnNewItem()
		item.position = spot.global_position
		spot.hold_item(item)
