extends Control

var hiscoresFilePath = "res://assets/text/hiscores.json"
var userHiscoresFilePath = "user://hiscores.json"
var hiscores = Array([], TYPE_OBJECT, "Node", ScoreEntry)
@onready var current_level = null

func _ready():
	load_hiscores()
	populateScoresList()
	
func load_hiscores():
	if not FileAccess.file_exists(userHiscoresFilePath):
		DirAccess.copy_absolute(hiscoresFilePath, userHiscoresFilePath)
	
	var save_file = FileAccess.open(userHiscoresFilePath, FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		# Creates the helper class to interact with JSON.
		var json = JSON.new()
		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		# Get the data from the JSON object.
		var node_data = json.data
		
		# Firstly, we need to create the object and add it to the tree and set its position.
		var newScore:ScoreEntry = load("res://scenes/components/score_entry.tscn").instantiate()

		# Now we set the remaining variables.
		newScore.gameMode = node_data["gameMode"]
		newScore.dateScored = node_data["dateScored"]
		newScore.score = str(node_data["score"]).pad_decimals(0)
		hiscores.append(newScore)
		
func populateScoresList():
	var oldscores :=$Control/ScoresList/Scores.get_children()
	for child in oldscores:
		$Control/ScoresList/Scores.remove_child(child)
	hiscores.sort_custom(
		func(a: ScoreEntry, b:ScoreEntry): return a.score < b.score
	)
	for i in hiscores:
		$Control/ScoresList/Scores.add_child(i)
		
func saveScoresList():
	var save_file = FileAccess.open(userHiscoresFilePath, FileAccess.WRITE)	
	for node in hiscores:
		var node_data = node.call("save")
		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)
		# Store the save dictionary as a new line in the save file.
		save_file.store_line(json_string)
