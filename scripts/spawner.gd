class_name Item_Spawner extends Node2D

var level

var scenes = []

func _on_button_pressed() -> void:
	SpawnNewItem()

func SpawnNewItem():
	var item = scenes[RandomNumberGenerator.new().randi() % len(scenes)]
	var newItem = item.instantiate()
	newItem.type = item
	newItem.scale = Vector2(3,3)
	Globals.game.currentLevel.add_child(newItem)
	return newItem

func _ready() -> void:
	for item in Globals.groceries:
		scenes.append(load(item))
		
