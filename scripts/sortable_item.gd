extends Node2D

var isFollowingMouse = false
var grabable = false
var target = Vector2.ZERO
var speed = 5
var velocity
#var hoveringArea
var lastHoveredArea = null
var currentArea = null
var lastArea = null

func _ready():
	pass
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		handleClick()
			
	if isFollowingMouse:
		move()
		
func move():
	position = get_global_mouse_position()

func handleClick():
	if isFollowingMouse:
		drop()
	else:
		tryGrab()

func drop():
	var level = get_tree().get_root().get_node("Level")
	level.drop_sortable()
	isFollowingMouse = false
	z_index = 500
	if lastHoveredArea != null \
	&& $Area2D.overlaps_area(lastHoveredArea) \
	&& lastHoveredArea.get_parent().heldSortable == null :
		global_position = lastHoveredArea.global_position
		if lastArea != null:
			lastArea.get_parent().remove_sortable()
		lastArea = lastHoveredArea
		lastHoveredArea.get_parent().hold_sortable($".")
	elif lastArea != null:
		lastArea.get_parent().hold_sortable($".")
		
		
	
func tryGrab():
	var level = get_tree().get_root().get_node("Level")
	if level.carriedSortable == null && grabable:
		if !lastArea == null:
			lastArea.get_parent().remove_sortable()
		z_index = 1000
		isFollowingMouse = true
		level.hold_sortable($".")

func _on_area_2d_area_entered(area: Area2D) -> void:
	lastHoveredArea = area

func _on_area_2d_mouse_entered() -> void:
	grabable = true
func _on_area_2d_mouse_exited() -> void:
	grabable = false
