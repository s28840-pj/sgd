extends Control

@onready var player1 = $HBoxContainer/Player_1_Container/Player_1_Button
@onready var player2 = $HBoxContainer/Player_2_Container/Player_2_Button
@onready var player3 = $HBoxContainer/Player_3_Container/Player_3_Button
@onready var player4 = $HBoxContainer/Player_4_Container/Player_4_Button

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	#GameManager.level = 1
	#GameManager.score = 0
	
	if GameManager.playerSpriteIndex == 1:
		player1.disabled = true
		player1.text = "Selected"
	if GameManager.playerSpriteIndex == 2:
		player2.disabled = true
		player2.text = "Selected"
	if GameManager.playerSpriteIndex == 3:
		player3.disabled = true
		player3.text = "Selected"
	if GameManager.playerSpriteIndex == 4:
		player4.disabled = true
		player4.text = "Selected"
	
	GameManager.hide_canvas()

func change_button(previousIndex:int):
	if previousIndex == 1:
		player1.disabled = false
		player1.text = "Select"
	if previousIndex == 2:
		player2.disabled = false
		player2.text = "Select"
	if previousIndex == 3:
		player3.disabled = false
		player3.text = "Select"
	if previousIndex == 4:
		player4.disabled = false
		player4.text = "Select"
	

func _on_play_pressed() -> void:
	GameManager.level = 1
	GameManager.score = 0
	get_tree().change_scene_to_file("res://level/level.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/menu.tscn")

func _on_player_1_button_pressed() -> void:
	change_button(GameManager.playerSpriteIndex)
	GameManager.playerSpriteIndex = 1
	player1.disabled = true
	player1.text = "Selected"

func _on_player_2_button_pressed() -> void:
	change_button(GameManager.playerSpriteIndex)
	GameManager.playerSpriteIndex = 2
	player2.disabled = true
	player2.text = "Selected"

func _on_player_3_button_pressed() -> void:
	change_button(GameManager.playerSpriteIndex)
	GameManager.playerSpriteIndex = 3
	player3.disabled = true
	player3.text = "Selected"

func _on_player_4_button_pressed() -> void:
	change_button(GameManager.playerSpriteIndex)
	GameManager.playerSpriteIndex = 4
	player4.disabled = true
	player4.text = "Selected"
