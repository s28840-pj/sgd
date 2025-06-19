extends Node2D

@onready var pause_menu = $Camera2D/Pause_Menu
var paused = false

var columns = 26
var rows = 3
var margin_up = 80
var margin_x = 85
var balls = 0

func _ready() -> void:
	GameManager.show_canvas()
	GameManager.bricksLeft = 0
	
	$Player.changePlayerSprites(GameManager.playerSpriteIndex)
	
	setupLevel()

func setupLevel():
	$themeSong.playing = true
	
	var ball = Ball.create()
	ball.exited_screen.connect(_on_ball_exit)
	add_child(ball)
	balls += 1
	
	rows = 2 + GameManager.level
	
	if rows > 6:
		rows = 6
	
	var colors = getColors()
	
	for r in rows:
		for c in columns:
			
			var randomNumber = randi_range(0,2)
			if randomNumber > 0:
				
				var brickFab = Sniper
				if GameManager.level > 1 && randi_range(GameManager.level * 5, 100) > 60:
					brickFab = Tank

				var newBrick = brickFab.create(Vector2(margin_x + (70 * c), margin_up + (70 * r)))
				GameManager.bricksLeft += 1
				add_child(newBrick)
				
				#TODO: add 3rd enemy
				var sprite = newBrick.get_node('Brick_Sprite') 
				var randomNumberColors = randi_range(0,3)
				if randomNumberColors == 0:
					sprite.modulate = colors[0]
				elif randomNumberColors == 1:
					sprite.modulate = colors[1]
				elif randomNumberColors == 2:
					sprite.modulate = colors[2]
				elif randomNumberColors == 3:
					sprite.modulate = colors[3]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	
	GameManager.multiplySpeed = GameManager.score / 20
	if GameManager.multiplySpeed > 0:
		$themeSong.pitch_scale = 1.0 + GameManager.multiplySpeed * 0.005
	else:
		$themeSong.pitch_scale = 1.0
	
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
	

func getColors():
	var colors = [
		Color(0.980392, 0.921569, 0.843137, 1),
		Color(0.960784, 0.960784, 0.862745, 1),
		Color(0.564706, 0.933333, 0.564706, 1),
		Color(0.686275, 0.933333, 0.933333, 1)
	]
	return colors
	
func get_random_ball_position() -> Vector2:
	var min_x = 100
	var max_x = 1850
	var y_pos = 500

	return Vector2(randi_range(min_x, max_x), y_pos)

func game_over() -> void:
	get_tree().change_scene_to_file("res://game_over_screen/game_over.tscn")

func _on_Player_got_hit() -> void:
	game_over()

func _on_ball_exit() -> void:
	balls -= 1
	if balls == 0:
		game_over()
