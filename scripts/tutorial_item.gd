class_name Tutorial_Item extends SortableItem

func _ready() -> void:
	super()
	#isGrabbable = false

func drop():
	pass

func set_grabbable(newGrabbable: bool):
	isGrabbable = newGrabbable
