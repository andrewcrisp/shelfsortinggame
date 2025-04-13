extends Button

var spawner

func _ready() -> void:
	spawner = get_tree().get_root().get_node("Level").get_node("item_spawner")

func _on_pressed() -> void:
	var item = spawner.SpawnNewItem()
	item.position = global_position - Vector2(25, 0)
