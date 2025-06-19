extends Control

@onready var level = $"../../"

func _on_resume_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	level.pauseMenu()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_main_menu_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	level.pauseMenu()
	get_tree().change_scene_to_file("res://menu/menu.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
