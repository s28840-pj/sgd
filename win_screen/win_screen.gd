extends Control

var highscores = {}

func _spawn_fireworks_loop() -> void:
	while true:
		var firework = preload("res://win_screen/firework.tscn").instantiate()
		var colors = getColors()
		firework.color = colors[randi_range(0, 3)]
		firework.position = Vector2(randi_range(100, 1820), randi_range(100, 980))
		firework.show_behind_parent = true
		add_child(firework)
		firework.emitting = true

		await get_tree().create_timer(2).timeout

func spawn_fireworks():
	_spawn_fireworks_loop()
	
func getColors():
	return [
		Color.RED,
		Color.GREEN,
		Color.BLUE,
		Color.YELLOW
	]

func _ready() -> void:
	var score_text = $MarginContainer/VBoxContainer/Score_Box/Score_Text
	var level_text = $MarginContainer/VBoxContainer/Level_Box/Level_Text
	
	GameManager.addCoins(GameManager.score)
	GameManager.hide_canvas()
	GameManager.save_user_settings(GameManager.coins, GameManager.playerSpriteIndex)
	
	GameManager.level = 10
	
	score_text.text = str(GameManager.score)
	level_text.text = str(GameManager.level)
	
	load_highscores()
	
	spawn_fireworks()


func save_highscore(player_name, score):
	highscores[player_name] = score
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

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/menu.tscn")
