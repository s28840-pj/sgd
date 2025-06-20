extends Node

var score = 0
var level = 1
var multiplySpeed = 0
var playerSpriteIndex = 1
var active_balls = 1
var wide_powerup: bool = false
var wide_powerup_used: bool = false
var double_ball_powerups: int = 0
var player_health: int = 1
var player_max_health: int = 1
var cheat_mode: bool = false
var coins

func addPoints(points):
	score += points
	

func addCoins(value):
	coins += value

func subtractCoins(value):
	coins -= value
	
func load_user_settings():
	var config = ConfigFile.new()
	var err = config.load("user://user_settings.cfg")
	if err != OK:
		coins = 0
		playerSpriteIndex = 1
	coins = config.get_value("user","coins",0)
	playerSpriteIndex = config.get_value("user","playerSpriteIndex", 1)

func save_user_settings(coins: int, playerSpriteIndex: int):
	var config = ConfigFile.new()
	config.load("user://user_settings.cfg")
	var previousCoins = config.get_value("user","coins")
	config.set_value("user","coins",coins)
	config.set_value("user","playerSpriteIndex", playerSpriteIndex)
	config.save("user://user_settings.cfg")

func hide_canvas():
	$CanvasLayer/ScoreLabel.hide()
	$CanvasLayer/LevelLabel.hide()
	$CanvasLayer/PowerupLabel.hide()
	$CanvasLayer/HealthLabel.hide()

func show_canvas():
	$CanvasLayer/ScoreLabel.show()
	$CanvasLayer/LevelLabel.show()
	$CanvasLayer/PowerupLabel.show()
	$CanvasLayer/HealthLabel.show()
	
func _process(delta: float) -> void:
	$CanvasLayer/ScoreLabel.text = "Score: " + str(score)
	$CanvasLayer/LevelLabel.text = "Level: " + str(level)
	$CanvasLayer/HealthLabel.text = "Health: " + str(player_health)
	update_powerup_label()
	
	if GameManager.cheat_mode == true:
		$CanvasLayer/CheatMode.visible = true
	else:
		$CanvasLayer/CheatMode.visible = false
	
	if Input.is_action_just_pressed("cheat"):
		var cheatMode = GameManager.cheat_mode
		GameManager.cheat_mode = !cheatMode
		

func update_powerup_label():
	var powerup_text_lines = []
	
	if wide_powerup:
		powerup_text_lines.append("Wide Player: ON")
		
	if double_ball_powerups > 0:
		powerup_text_lines.append("Double Balls: " + str(double_ball_powerups))
	
	if powerup_text_lines.is_empty():
		$CanvasLayer/PowerupLabel.text = "No powerups"
	else:
		$CanvasLayer/PowerupLabel.text = "\n".join(powerup_text_lines)
