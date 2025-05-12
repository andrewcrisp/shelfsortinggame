class_name SortableItem extends Node2D

var type = "untyped"
var isFollowingMouse = false
var dragposition = 0
var lastArea: Spot
var hoveredArea = null
var isGrabbable = true
var mySprite: Sprite2D
var myShape
var current_shader

func _ready() -> void:
	$SortableItemShape.connect("area_entered", _on_area_2d_area_entered)
	$SortableItemShape.connect("area_exited", _on_area_2d_area_exited)
	mySprite = $Sprite2D
	myShape = $SortableItemShape/CollisionShape2D
	resetCollisionShape()
	pass
	
func resetCollisionShape():
	if $Sprite2D.region_enabled:
		$SortableItemShape/CollisionShape2D.shape.size = $Sprite2D.region_rect.size * 1.1
	else:
		$SortableItemShape/CollisionShape2D.shape.size = $Sprite2D.texture.get_size()

func setShader():
	$Sprite2D.material.shader = current_shader

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
		|| event is InputEventScreenTouch):
		if (event.is_pressed()):
			var localPos = to_local(event.position)
			var boundbox:Shape2D = $SortableItemShape/CollisionShape2D.shape
			if boundbox.get_rect().has_point(localPos):
				tryGrab()
		else:
			drop()
	if isFollowingMouse:
		dragposition = event.position
	
func _process(_delta: float) -> void:
	if (isFollowingMouse):
		global_position = dragposition

func drop():
	if isFollowingMouse:
		isFollowingMouse = false
		mySprite.material.set_shader_parameter("width", 0)
		Globals.current_level.drop_item()
		
		z_index = Globals.z_levels["placed_item"]
		if (hoveredArea != null
			&& $SortableItemShape.overlaps_area(hoveredArea)
			&& hoveredArea.get_parent().heldItem == null) :
			hoveredArea.get_parent().hold_item($".")

func tryGrab():
	if (isGrabbable
	&& Globals.current_level.carriedItem == null):
		z_index = Globals.z_levels["held_item"]
		isFollowingMouse = true
		Globals.current_level.hold_item($".")
		mySprite.material.set_shader_parameter("width", 10.0)

func use_background_shader():
	$Sprite2D.scale = Vector2(.8,.8)
	$Sprite2D.material.shader = Globals.background_item_shader

func use_carried_item_shader():
	$Sprite2D.scale = Vector2(1,1)
	$Sprite2D.material.shader = Globals.carried_item_shader
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	hoveredArea = area

func _on_area_2d_area_exited(area: Area2D) -> void:
	if (hoveredArea == area):
		hoveredArea = null
		
func send_to_scoreboard_callback():
	$".".queue_free()
	
func send_to_scoreboard():
	Globals.current_level.myScoreboard.bounce_scoreboard()
	var tween = create_tween()	
	tween.set_loops(1).tween_property($Sprite2D, "global_position", Globals.current_level.myScoreboard.global_position, .5)
	tween.parallel().tween_property($"Sprite2D", "scale", Vector2(), .5)
	tween.tween_callback(send_to_scoreboard_callback)
