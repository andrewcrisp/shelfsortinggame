extends Node2D
var item
var level

var scenes = []

func _on_button_pressed() -> void:
	SpawnNewItem()

func SpawnNewItem():
	var newItem = item.instantiate()
	#newItem.position = global_position
	newItem.scale = Vector2(4,4)
	get_tree().get_root().get_node("Level").add_child(newItem)
	return newItem

func _ready() -> void:
	item = preload("res://scenes/peach.tscn")
	
