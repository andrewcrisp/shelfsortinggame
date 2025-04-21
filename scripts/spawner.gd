class_name Item_Spawner extends Node2D

var level

var scenes = []

func _on_button_pressed() -> void:
	SpawnNewItem()

func SpawnNewItem():
	var randItemNumber = RandomNumberGenerator.new().randi() % (len(scenes) + 1)
	if (randItemNumber == len(scenes)):
		return null
	var item = scenes[randItemNumber]
	var newItem = item.instantiate()
	newItem.type = item
	newItem.scale = Vector2(6,6)
	Globals.game.current_level.call_deferred("add_child", newItem)
	return newItem

func _ready() -> void:
	for item in Globals.groceries:
		scenes.append(load(item))
		
