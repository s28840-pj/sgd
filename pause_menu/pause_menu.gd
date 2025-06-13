extends Control

@onready var level = $"../../"

func _on_resume_pressed() -> void:
	level.pauseMenu()

func _on_main_menu_pressed() -> void:
	level.pauseMenu()
	get_tree().change_scene_to_file("res://menu/menu.tscn")
