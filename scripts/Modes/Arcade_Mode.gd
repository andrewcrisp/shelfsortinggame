class_name Arcade_Mode extends Timed_Mode

func _ready() -> void:
	Globals.current_level.connect("score", increment_timer)
