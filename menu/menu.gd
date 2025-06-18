extends Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	#GameManager.level = 1
	#GameManager.score = 0
	
	GameManager.hide_canvas()

func _on_play_pressed() -> void:
	GameManager.level = 1
	GameManager.score = 0
	get_tree().change_scene_to_file("res://level/level.tscn")

func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://shop_menu/shop_menu.tscn")

func _on_leaderboard_pressed() -> void:
	get_tree().change_scene_to_file("res://leaderboards/leaderboards.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://options_menu/options_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit(0)
