extends Control

var highscores = {}

func _ready() -> void:
	var score_text = $MarginContainer/VBoxContainer/Score_Box/Score_Text
	var level_text = $MarginContainer/VBoxContainer/Level_Box/Level_Text
	
	score_text.text = str(GameManager.score)
	level_text.text = str(GameManager.level)
	
	load_highscores()

func save_highscore(player_name, score):
	highscores[player_name] = score
	# Save to file
	var file = FileAccess.open("user://leaderboard.txt", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(highscores))
		file.close()
	else:
		print("Error opening file for writing")

func load_highscores():
	var file = FileAccess.open("user://leaderboard.txt", FileAccess.READ)
	if file:
		var data = file.get_as_text()
		file.close()
		if data.length() > 0:
			highscores = JSON.parse_string(data)
		else:
			highscores = {}
	else:
		print("Error opening file for reading")

func _on_line_edit_text_submitted(new_text: String) -> void:
	_on_confirm_pressed()

func _on_confirm_pressed() -> void:
	var player_name = $MarginContainer/VBoxContainer/LineEdit.text
	if (player_name == ""):
		$MarginContainer/VBoxContainer/Error_label.show()
		$MarginContainer/VBoxContainer/Error_label.text = "Player Name cannot be empty"
		return
	var player_score = GameManager.score
	if (player_score < 1):
		$MarginContainer/VBoxContainer/Error_label.show()
		$MarginContainer/VBoxContainer/Error_label.text = "Sorry, Score too low"
		return
	save_highscore(player_name,player_score)
	var confirmButton = $MarginContainer/VBoxContainer/Confirm
	confirmButton.disabled = true
	confirmButton.text = "Score Added"
	$MarginContainer/VBoxContainer/Error_label.hide()


func _on_restart_pressed() -> void:
	GameManager.level = 1
	GameManager.score = 0
	get_tree().change_scene_to_file("res://game/level.tscn")


func _on_main_menu_pressed() -> void:
	GameManager.level = 1
	GameManager.score = 0
	get_tree().change_scene_to_file("res://menu/menu.tscn")
