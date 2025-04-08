extends Node

var z_levels = {
	"background" = 0,
	"held_item" = 1000,
	"placed_item" = 500
}

var fruit = []

func _ready() -> void:
	fruit.append("res://scenes/peach.tscn")
