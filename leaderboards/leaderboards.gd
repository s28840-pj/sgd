extends Control

var highscores = {}

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	load_highscores()
	show_highscores()

func _on_back_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	get_tree().change_scene_to_file("res://menu/menu.tscn")

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
	
func show_highscores():
	var scores_array = highscores.keys().map(
		func(name):
			return { "name": name, "score": highscores[name] }
	)
	scores_array.sort_custom(func(a, b): return int(b["score"] < a["score"]))
	scores_array = scores_array.slice(0, 10)

	var container = $MarginContainer/VBoxContainer/Leaderboard_Container

	for child in container.get_children():
		child.queue_free()

	for entry in scores_array:
		var label = Label.new()
		label.text = "%s: %s" % [entry["name"], int(entry["score"])]
		container.add_child(label)
