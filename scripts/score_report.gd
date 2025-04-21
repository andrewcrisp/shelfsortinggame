class_name ScoreReport extends Node2D

func _ready():
	var viewportSize = get_viewport().get_visible_rect().size
	$Control.size = viewportSize
