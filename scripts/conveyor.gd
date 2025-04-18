class_name Conveyor extends Node2D

signal itemRequested(spot: Spot)

var maxSpots: int = 3
var spots: Array
var spawner = null
var velocity = 100 #100


func _process(delta: float) -> void:
	$Path2D/PathFollow2D.h_offset += velocity * delta
	$Path2D/PathFollow2D2.h_offset += velocity * delta
	$Path2D/PathFollow2D3.h_offset += velocity * delta

func _ready() -> void:
	var curve:Curve2D = $Path2D.curve
	$spawner.position = curve.get_point_position(0)
	$despawner.position = curve.get_point_position(1)
	$despawner.connect("area_entered", _on_despawner_entered)
	var curveLength = curve.get_baked_length()
	$Path2D/PathFollow2D.h_offset = curveLength / (maxSpots) * 0
	$Path2D/PathFollow2D2.h_offset = curveLength / (maxSpots) * 1
	$Path2D/PathFollow2D3.h_offset = curveLength / (maxSpots) * 2
	
	connect("itemRequested", addItem)
	
func _on_despawner_entered(area: Area2D):
	var spot = area.get_parent()
	spot.global_position = $spawner.global_position
	itemRequested.emit(spot)
	#addItem(spot)
	
func addItem(spot):
	if !spot.isHoldingItem():
		var item = Globals.itemSpawner.SpawnNewItem()
		if (item != null):
			item.position = spot.global_position
			spot.hold_item(item)
