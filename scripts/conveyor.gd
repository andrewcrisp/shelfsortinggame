extends Node2D

var spot

var maxSpots: int = 3
var spots: Array

func _process(delta: float) -> void:
	$Path2D/PathFollow2D.h_offset += 50 * delta	
		
	if spots.is_empty():
		SpawnSpot()
	#else:
		#print(str(spots[0].position))
		
func _ready() -> void:
	spot = preload("res://scenes/spot.tscn")
	var curve:Curve2D = $Path2D.curve
	var startPosition = curve.get_point_position(0)
	$spawner.position = startPosition
	print("Spawner global position " + str($spawner.global_position))
	$despawner.position = curve.get_point_position(1)
	print("Despawner global position " + str($despawner.global_position))
	
func SpawnSpot():
	var newspot = spot.instantiate()
	newspot.scale = Vector2(4,4)
	
	$despawner.connect("area_entered", _on_despawner_entered)
	$Path2D/PathFollow2D.add_child(newspot)
	newspot.position = $spawner.position
	print("new spot at position " + str(newspot.global_position))
	spots.append(newspot)

func _on_despawner_entered(area: Area2D):
	print("Despawner hit")
	print("moving to " + str($spawner.global_position))
	area.get_parent().global_position = $spawner.global_position
	print("moved to " + str(area.global_position))
	
