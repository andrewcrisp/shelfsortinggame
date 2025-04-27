extends Control

var hiscoresFilePath = "res://assets/text/hiscores.json"
var userHiscoresFilePath = "user://hiscores.json"
var hiscores = Array([], TYPE_OBJECT, "Node", ScoreEntry)

func _ready():
	load_hiscores()
	populateScoresList()
	
func load_hiscores():
	if FileAccess.file_exists(userHiscoresFilePath):
		DirAccess.remove_absolute(userHiscoresFilePath)
	
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

		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			var gamemode = i
			for score in node_data[i]:
				var newScore:ScoreEntry = load("res://scenes/score_entry.tscn").instantiate()
				newScore.gameMode = i
				newScore.dateScored = score.dateScored
				newScore.score = str(score["score"])
				hiscores.append(newScore)
				#$Control/ScoresList/Scores.add_child(newScore)
			
func populateScoresList():
	for i in hiscores:
		$Control/ScoresList/Scores.add_child(i)
