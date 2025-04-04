extends Node2D

var isFollowingMouse = false
var grabable = false
var target = Vector2.ZERO
var speed = 5
var velocity
var hoveringArea
var lastArea

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
		grab()

func drop():
	isFollowingMouse = false
	if hoveringArea != null && $Area2D.overlaps_area(hoveringArea):
		position = hoveringArea.global_position
		lastArea = hoveringArea
	elif lastArea != null:
		position = lastArea.global_position
		
	
func grab():
	if grabable:
		isFollowingMouse = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	hoveringArea = area

func _on_area_2d_area_exited(_area: Area2D) -> void:
	hoveringArea = null


func _on_area_2d_mouse_entered() -> void:
	grabable = true


func _on_area_2d_mouse_exited() -> void:
	grabable = false
