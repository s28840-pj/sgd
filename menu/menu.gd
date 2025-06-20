extends Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if not MenusMusic.is_playing():
		MenusMusic.play()
	
	#GameManager.level = 1
	#GameManager.score = 0
	
	GameManager.hide_canvas()
	GameManager.load_user_settings()
	

func _on_play_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	GameManager.level = 1
	GameManager.score = 0
	get_tree().change_scene_to_file("res://select_screen/select_screen.tscn")

func _on_shop_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	get_tree().change_scene_to_file("res://shop_menu/shop_menu.tscn")

func _on_leaderboard_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	get_tree().change_scene_to_file("res://leaderboards/leaderboards.tscn")

func _on_options_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	get_tree().change_scene_to_file("res://options_menu/options_menu.tscn")

func _on_quit_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	get_tree().quit(0)
