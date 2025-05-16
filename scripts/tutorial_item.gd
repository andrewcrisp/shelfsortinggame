class_name Tutorial_Item extends SortableItem

var drop_target
var ready_to_use = false

func _ready() -> void:
	super()
	isGrabbable = false

func drop():
	if (drop_target == hoveredArea):
		super()
		if ready_to_use:
			Globals.current_level.complete_move()
	else:
		isFollowingMouse = false
		mySprite.material.set_shader_parameter("width", 0)
		Globals.current_level.drop_item()
		z_index = Globals.z_levels["placed_item"]

func set_drop_target(target: Area2D):
	drop_target = target
	
func set_grabbable(newGrabbable: bool):
	isGrabbable = newGrabbable
