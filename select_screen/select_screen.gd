extends Control

@onready var players: Array[Button] = [
	$HBoxContainer/Player_1_Container/Player_1_Button,
	$HBoxContainer/Player_2_Container/Player_2_Button,
	$HBoxContainer/Player_3_Container/Player_3_Button,
	$HBoxContainer/Player_4_Container/Player_4_Button
]

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	var index: int = GameManager.playerSpriteIndex - 1
	if index >= 0 and index < players.size():
		_set_button_state(index, true)
	
	GameManager.hide_canvas()

func change_button(previousIndex: int):
	var index: int = previousIndex - 1
	if index >= 0 and index < players.size():
		_set_button_state(index, false)

func _set_button_state(index: int, selected: bool) -> void:
	var button: Button = players[index]
	button.disabled = selected
	button.text = "Selected" if selected else "Select"

func _on_play_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	GameManager.level = 1
	GameManager.score = 0
	get_tree().change_scene_to_file("res://level/level.tscn")

func _on_back_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	get_tree().change_scene_to_file("res://menu/menu.tscn")

func _on_player_button_pressed(index: int) -> void:
	MenuButtonsSfx.play_button_click()
	change_button(GameManager.playerSpriteIndex)
	GameManager.playerSpriteIndex = index + 1
	GameManager.player_max_health = 1 + (GameManager.playerSpriteIndex - 1)
	GameManager.player_health = GameManager.player_max_health
	GameManager.save_user_settings(GameManager.coins,GameManager.playerSpriteIndex)
	_set_button_state(index, true)

func _on_player_1_button_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	_on_player_button_pressed(0)

func _on_player_2_button_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	_on_player_button_pressed(1)

func _on_player_3_button_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	_on_player_button_pressed(2)

func _on_player_4_button_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	_on_player_button_pressed(3)
