class_name Item_Spawner extends Node2D

var level

var scenes = []
var itemTextures = []

var sortableItemScene
var lastTwoItems = [null, null]


func _on_button_pressed() -> void:
	SpawnNewItem()
	
func GetRandomItemTexture():
	var randomDivisor = 1
	var randItemNumber = RandomNumberGenerator.new().randi() % (len(itemTextures) + (len(itemTextures)/randomDivisor ))
	if (randItemNumber >= len(itemTextures)):
		return null
	var item = itemTextures[randItemNumber]
	return item

func GetRandomItemScene():
	var randomDivisor = 4
	var randItemNumber = RandomNumberGenerator.new().randi() % (len(scenes) + (len(scenes)/randomDivisor ))
	
	if (randItemNumber >= len(scenes)):
		return null
	var item = scenes[randItemNumber]
	return item
	
func SpawnNewItem():
	return SpawnNewItemFromTextureList()
	#return SpawnNewItemFromScene()
	
func SpawnNewItemFromTextureList():
	var itemTexture = GetRandomItemTexture()
	if (itemTexture == null):
		return null
	while !CheckSaneItemSpawns(itemTexture):
		itemTexture = GetRandomItemTexture()
	var newItem:SortableItem = sortableItemScene.instantiate()
	newItem.type = itemTexture
	newItem.scale = Vector2(.5,.5)
	var sprite: Sprite2D = newItem.get_node("Sprite2D")	
	sprite.texture = itemTexture
	Globals.current_level.call_deferred("add_child", newItem)
	return newItem
	
func SpawnNewItemFromScene():
	var item = GetRandomItemScene()
	if (item == null):
		return null
	while !CheckSaneItemSpawns(item):
		item = GetRandomItemScene()
	var newItem:SortableItem = item.instantiate()
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
	#load_asset_pack()
	load_item_textures()
	sortableItemScene = load("res://scenes/sortable_item.tscn")
		
func load_asset_pack():
	var success = ProjectSettings.load_resource_pack("res://assets.pck")
	print(success)
	pass
	
func load_item_textures():
	var path = "res://assets/items/tools"
	var dir := DirAccess.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with(".") and file_name.ends_with(".import"):
			itemTextures.append(load(path + "/" + file_name.replace(".import", "")))
		elif !file_name.begins_with(".") and !file_name.ends_with(".import"):
			#if !file_name.ends_with(".import"):
			itemTextures.append(load(path + "/" + file_name))
	dir.list_dir_end()
