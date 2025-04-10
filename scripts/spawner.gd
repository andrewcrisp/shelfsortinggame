extends Node2D
#var peach
var level

var scenes = []

func _on_button_pressed() -> void:
	SpawnNewItem()

func SpawnNewItem():
	var item = scenes[RandomNumberGenerator.new().randi() % len(scenes)]
	var newItem = item.instantiate()
	#newItem.position = global_position
	newItem.scale = Vector2(4,4)
	get_tree().get_root().get_node("Level").add_child(newItem)
	return newItem

func _ready() -> void:
	#peach = preload("res://scenes/groceries/peach.tscn")
	scenes.append(preload("res://scenes/groceries/peach.tscn"))
	scenes.append(preload("res://scenes/groceries/wheat.tscn"))
	scenes.append(preload("res://scenes/groceries/wheat_packet.tscn"))
	scenes.append(preload("res://scenes/groceries/peach_packet.tscn"))
