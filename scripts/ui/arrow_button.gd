extends Node2D

signal clicked

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
		|| event is InputEventScreenTouch):
		if (event.is_action_pressed("click")):
			var localPos = to_local(event.position)
			var boundbox:Shape2D = $ClickArea/CollisionShape2D.shape
			if boundbox.get_rect().has_point(localPos):
				print("Clicked arrow button")
				emit_signal("clicked")
