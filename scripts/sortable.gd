extends Node2D

var level
var isFollowingMouse = false
var grabable = false
var target = Vector2.ZERO
var speed = 5
var velocity
#var hoveringArea
var lastHoveredArea = null
var currentArea = null
var lastArea = null

func _ready() -> void:
	level = get_tree().get_root().get_node("Level")
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		handleClick()
			
	if isFollowingMouse:
		move()
		
func move():
	get_parent().position = get_global_mouse_position()

func handleClick():
	if isFollowingMouse:
		drop()
	else:
		tryGrab()

func drop():
	level.drop_item()
	isFollowingMouse = false
	z_index = Globals.z_levels["placed_item"]
	if (lastHoveredArea != null
	&& get_parent().get_node("Area2D").overlaps_area(lastHoveredArea)
	&& lastHoveredArea.get_parent().heldItem == null) :
		global_position = lastHoveredArea.global_position
		lastArea = lastHoveredArea
		lastHoveredArea.get_parent().hold_item(get_parent())
	elif lastArea != null:
		lastArea.get_parent().hold_item(get_parent())
	
func tryGrab():
	if level.carriedItem == null && grabable:
		if !lastArea == null:
			lastArea.get_parent().remove_item()
		z_index = Globals.z_levels["held_item"]
		isFollowingMouse = true
		level.hold_item(get_parent())

func _on_area_2d_area_entered(area: Area2D) -> void:
	lastHoveredArea = area

func _on_area_2d_mouse_entered() -> void:
	grabable = true
func _on_area_2d_mouse_exited() -> void:
	grabable = false
