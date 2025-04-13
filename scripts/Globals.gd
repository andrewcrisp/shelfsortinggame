extends Node

var z_levels = {
	"background" = 0,
	"held_item" = 1000,
	"placed_item" = 500
}

var groceries = []

func _ready() -> void:
	groceries.append("res://scenes/groceries/sunflower.tscn")
	#groceries.append("res://scenes/groceries/wheat.tscn")
	#groceries.append("res://scenes/groceries/peach.tscn")
	#groceries.append("res://scenes/groceries/wheat_packet.tscn")
	#groceries.append("res://scenes/groceries/peach_packet.tscn")
