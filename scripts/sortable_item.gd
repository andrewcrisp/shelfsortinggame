extends Node2D

var type = "untyped"
var isFollowingMouse = false
var dragposition = 0
var lastArea
var hoveredArea = null
#var mouse_in = false
	
func _ready() -> void:
	$"Area2D/CollisionShape2D".shape.size = $Sprite2D.region_rect.size * 1.1
	#$Area2D.connect("mouse_entered", _on_area_2d_mouse_entered)
	#$Area2D.connect("mouse_exited", _on_area_2d_mouse_exited)
	$Area2D.connect("area_entered", _on_area_2d_area_entered)
	$Area2D.connect("area_exited", _on_area_2d_area_exited)
	
func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
		|| event is InputEventScreenTouch):
		if (event.is_pressed()):
			var localPos = to_local(event.position)
			var boundbox:Shape2D = $Area2D/CollisionShape2D.shape
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
		&& $"Area2D".overlaps_area(hoveredArea)
		&& hoveredArea.get_parent().heldItem == null) :
			global_position = hoveredArea.global_position
			lastArea = hoveredArea
			hoveredArea.get_parent().hold_item($".")
		elif lastArea != null:
			lastArea.get_parent().hold_item($".")
		
func tryGrab():
	if Globals.game.currentLevel.carriedItem == null:
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
