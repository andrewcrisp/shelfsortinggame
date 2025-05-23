extends Node2D

const section_time := 2.0
const line_time := 0.3
const base_speed := 100
const speed_up_multiplier := 10.0
const title_color := Color.BLUE_VIOLET

# var scroll_speed := base_speed
var speed_up := false

@onready var line := $CreditsContainer/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

var credits = [
	[
		"A game by Andrew"
	],[
		"Programming",
		"Andrew Crisp"
	],[
		"Art",
		"Prototype art by",
		"Cup Nooble",
		"https://cupnooble.itch.io/",
		"",
		"Final art by",
		"A-ravlik",
		"https://www.artstation.com/a-ravlik/store"
	],[
		"Testers",
		"Name 1"
	],[
		"Tools used",
		"Developed with Godot Engine",
		"https://godotengine.org/license",
		"",
		"Credits scrawl by benbishopnz",
		#"https://github.com/benbishopnz/godot-credits/tree/master",
		"https://github.com/benbishopnz/",
		"With edit for Godot4 by u/theRealDyer"
	],[
		"Special thanks",
		"My spouse",
		"ambid17"
	]
]

func _ready() -> void:
	$BackButton.connect("clicked", finish)
	#$CreditsContainer/Line.position.y = $CreditsContainer.position.y

func _process(delta):
	var scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.position.y -= scroll_speed
			#if l.position.y < $CreditsContainer.global_position.y:
			if l.position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		# This is called when the credits finish and returns to the main menu
		queue_free()
		Globals.game.show_starting_menu()

func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	new_line.position.y = $CreditsContainer.size.y
	if curr_line == 0:
		# new_line.add_color_override("font_color", title_color)
		new_line.set("theme_override_colors/font_color", title_color)
	$CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false
