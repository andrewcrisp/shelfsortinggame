extends Node2D

var level
var type = "untyped"
var isFollowingMouse = false
var dragposition = 0
var lastArea
var mouse_in = false
	
func _ready() -> void:
	level = get_tree().get_root().get_node("Level")
	$"Area2D/CollisionShape2D".shape.size = $Sprite2D.region_rect.size * 1.1
	$Area2D.connect("mouse_entered", _on_area_2d_mouse_entered)
	$Area2D.connect("mouse_exited", _on_area_2d_mouse_exited)

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		if (event.is_pressed()):
			tryGrab(event.position)
			#isFollowingMouse = true
		else:
			drop()
			#global_position = event.position
	if isFollowingMouse:
		dragposition = event.position
	
func _physics_process(delta: float) -> void:
	if (isFollowingMouse):
		global_position = dragposition

func drop():
	isFollowingMouse = false
	level.drop_item()
	
func tryGrab(grabPosition):
	if level.carriedItem == null && mouse_in:
		#if !lastArea == null:
			#lastArea.get_parent().remove_item()
		z_index = Globals.z_levels["held_item"]
		isFollowingMouse = true
		level.hold_item($".")

func _on_area_2d_mouse_entered() -> void:
	mouse_in = true
	print("in")

func _on_area_2d_mouse_exited() -> void:
	mouse_in = false
	print("out")
