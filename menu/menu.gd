extends Control

func _on_player_pressed() -> void:
	#GameManager.level = 1
	#GameManager.score = 0
	get_tree().change_scene_to_file("res://game/level.tscn")

func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://shop_menu/shop_menu.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://options_menu/options_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit(0)
