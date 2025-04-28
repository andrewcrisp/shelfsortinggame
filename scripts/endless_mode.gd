extends Node2D


func _ready() -> void:
	var viewportSize = get_viewport().get_visible_rect().size
	$Control.size = viewportSize
	
