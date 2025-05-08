extends timed_level

func _ready() -> void:
	Globals.current_level.connect("score", increment_timer)
