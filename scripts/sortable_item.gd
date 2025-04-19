class_name SortableItem extends Node2D

var type = "untyped"
var isFollowingMouse = false
var dragposition = 0
var lastArea
var hoveredArea = null
var isGrabbable = true

func _ready() -> void:
	$SortableItemShape/CollisionShape2D.shape.size = $Sprite2D.region_rect.size * 1.1
	$SortableItemShape.connect("area_entered", _on_area_2d_area_entered)
	$SortableItemShape.connect("area_exited", _on_area_2d_area_exited)
	
func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
		|| event is InputEventScreenTouch):
		if (event.is_pressed()):
			var localPos = to_local(event.position)
			var boundbox:Shape2D = $SortableItemShape/CollisionShape2D.shape
			if boundbox.get_rect().has_point(localPos):
				tryGrab()
		else:
			drop()
	if isFollowingMouse:
		dragposition = event.position
	
func _process(_delta: float) -> void:
	if (isFollowingMouse):
		global_position = dragposition

func drop():
	if isFollowingMouse:
		isFollowingMouse = false
		Globals.game.currentLevel.drop_item()
		
		z_index = Globals.z_levels["placed_item"]
		if (hoveredArea != null
		&& $SortableItemShape.overlaps_area(hoveredArea)
		&& hoveredArea.get_parent().heldItem == null) :
			lastArea = hoveredArea
			hoveredArea.get_parent().hold_item($".")
		elif lastArea != null:
			lastArea.get_parent().hold_item($".")
		
func tryGrab():
	if (isGrabbable
		&& Globals.game.currentLevel.carriedItem == null):
		if !lastArea == null:
			lastArea.get_parent().remove_item()
		z_index = Globals.z_levels["held_item"]
		isFollowingMouse = true
		Globals.game.currentLevel.hold_item($".")

func _on_area_2d_area_entered(area: Area2D) -> void:
	hoveredArea = area

func _on_area_2d_area_exited(area: Area2D) -> void:
	if (hoveredArea == area):
		hoveredArea = null
		
func send_to_scoreboard():
	var tween = create_tween()	
	tween.set_loops(1).tween_property($Sprite2D, "global_position", Globals.scoreboard.global_position, .5)
	tween.parallel().tween_property($"Sprite2D", "scale", Vector2(), .5)
	tween.tween_callback($".".queue_free)
