extends Node

var z_levels = {
	"background" = 0,
	"held_item" = 1000,
	"placed_item" = 500
}

var groceries = []

func _ready() -> void:
	groceries.append("res://scenes/peach.tscn")
