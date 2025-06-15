extends Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/menu.tscn")
