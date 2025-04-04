extends Node2D
var sortable
var level

func _on_button_pressed() -> void:
	SpawnNewSortable()

func SpawnNewSortable():
	var newsortable = sortable.instantiate()
	newsortable.position = global_position	
	get_tree().get_root().get_node("Level").add_child(newsortable)

func _on_ready() -> void:
	sortable = preload("res://scenes/sortable_item.tscn")
	
