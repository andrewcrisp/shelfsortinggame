extends Node2D

const MINUTES: int = 60
@onready var timer = $Timer
@onready var timedisplay = $Container/Label


func _ready() -> void:
	timer.wait_time = 2 * MINUTES
	#timer.start()
	timedisplay.text = String.num(timer.wait_time, 1)
	var viewportSize = get_viewport().get_visible_rect().size
	$Container.size = viewportSize
	timedisplay.position.x = viewportSize.x/2
	
func _process(_delta: float) -> void:
	if !(timer.is_stopped()):
		timedisplay.text = String.num(timer.time_left, 1)
