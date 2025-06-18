extends Node2D

@onready var brickObject = preload("res://level/brick/brick.tscn")
#@onready var wallObject = preload("res://level/walls/walls.tscn")

const brick1 = preload("res://art/brick1.png")
const brick2 = preload("res://art/brick2.png")

@onready var pause_menu = $Camera2D/Pause_Menu
var paused = false

var columns = 26
var rows = 3
var margin_up = 80
var margin_x = 85

func _ready() -> void:
	
	GameManager.show_canvas()
	GameManager.bricksLeft = 0
	
	$Player.changePlayerSprites(GameManager.playerSpriteIndex)
	
	setupLevel()

func setupLevel():
	
	$themeSong.playing = true
	
	$Ball.global_position = Vector2(randi_range(100,1850),500)
	
	rows = 2 + GameManager.level
	
	if rows > 6:
		rows = 6
	
	var colors = getColors()
	
	for r in rows:
		for c in columns:
			
			var randomNumber = randi_range(0,2)
			if randomNumber > 0:
				
				var newBrick = brickObject.instantiate()
				add_child(newBrick)
				GameManager.bricksLeft += 1
				newBrick.position = Vector2(margin_x + (70 * c), margin_up + (70 * r))
				
				if GameManager.level > 1:
					var randomNumberHealth = randi_range(GameManager.level * 5, 100)
					if randomNumberHealth > 60:
						newBrick.get_node('Brick_Sprite').texture = brick2
						newBrick.setHealth(2)
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
