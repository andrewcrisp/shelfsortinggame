class_name ModeButton extends Node2D

signal pressed

@export var label = ""

func _ready() -> void:
	$Label.text = label

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
		|| event is InputEventScreenTouch):
		if (event.is_action_pressed("click")
			&& isThisItemPressed(event)):
				emit_signal("pressed")

func isThisItemPressed(event: InputEvent):
		var localPos = to_local(event.position)
		var boundbox:Shape2D = $ClickArea/CollisionShape2D.shape
		return boundbox.get_rect().has_point(localPos)
