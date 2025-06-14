extends Control

func _on_restart_pressed() -> void:
	GameManager.level = 1
	GameManager.score = 0
	get_tree().change_scene_to_file("res://game/level.tscn")


func _on_main_menu_pressed() -> void:
	GameManager.level = 1
	GameManager.score = 0
	get_tree().change_scene_to_file("res://menu/menu.tscn")
