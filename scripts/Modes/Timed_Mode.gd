class_name Timed_Mode extends Node2D

@onready var timer = $Timer
@onready var timedisplay = $Container/Label


func _ready() -> void:
	timedisplay.text = String.num(timer.wait_time, 1)
	var viewportSize = get_viewport().get_visible_rect().size
	$Container.size = viewportSize
	timedisplay.position.x = viewportSize.x/2
	
	
func _process(_delta: float) -> void:
	if !(timer.is_stopped()):
		timedisplay.text = String.num(timer.time_left, 1)

func increment_timer(time: int=1):
	$Timer.start($Timer.time_left + time)
