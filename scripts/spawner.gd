class_name Item_Spawner extends Node2D

var level

var scenes = []

var lastTwoItems = [null, null]

func _on_button_pressed() -> void:
	SpawnNewItem()

func GetRandomItem():
	var randomDivisor = 4
	var randItemNumber = RandomNumberGenerator.new().randi() % (len(scenes) + (len(scenes)/randomDivisor ))
	
	if (randItemNumber >= len(scenes)):
		return null
	var item = scenes[randItemNumber]
	return item
	
func SpawnNewItem():
	var item = GetRandomItem()
	if (item == null):
		return null
	while !CheckSaneItemSpawns(item):
		item = GetRandomItem()
	var newItem = item.instantiate()
	newItem.type = item
	newItem.scale = Vector2(6,6)
	Globals.current_level.call_deferred("add_child", newItem)
	return newItem

func CheckSaneItemSpawns(newItem):
	if (newItem == null 
		|| (newItem == lastTwoItems[0]
		&& newItem == lastTwoItems[1])):
			return false
	else:
		lastTwoItems[0] = lastTwoItems[1]
		lastTwoItems[1] = newItem
		return true

func _ready() -> void:
	for item in Globals.groceries:
		scenes.append(load(item))
		
