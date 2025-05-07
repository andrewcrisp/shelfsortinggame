extends Node2D

signal clicked

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
		|| event is InputEventScreenTouch):
		if (event.is_pressed()):
			emit_signal("clicked")
