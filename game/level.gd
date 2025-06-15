extends Node2D

@onready var brickObject = preload("res://game/brick.tscn")
@onready var enemyObject = preload("res://game/enemy.tscn")

var columns = 26
var rows = 7
var margin = 75

func _ready() -> void:
	setupLevel()
	
func setupLevel():
	rows = 2 + GameManager.level
	
	if rows > 7:
		rows = 7
	
	var colors = getColors()
	colors.shuffle()
	for r in rows:
		for c in columns:
			var randomNumber = randi_range(0,2)
			if randomNumber > 0:
				#var newBrick = brickObject.instantiate()
				var newBrick = enemyObject.instantiate()
				add_child(newBrick)
				newBrick.position = Vector2(margin + (69*c), margin + (69*r))
				var sprite = newBrick.get_node('Sprite2D')
				if r <= 7:
					sprite.modulate = colors[0]
				if r < 5:
					sprite.modulate = colors[1]
				if r < 3:
					sprite.modulate = colors[2]

@onready var pause_menu = $Camera2D/Pause_Menu
var paused = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
	

func getColors():
	var Colors = [
		Color( 0, 1, 1, 1 ),
		Color( 0.54, 0.17, 0.89, 1 ),
		Color( 0.68, 1, 0.18, 1 ),
		Color( 1, 1, 1, 1 ),
	]
	return Colors

func audio_speedup(score) -> void:
	var new_pitch = 1.0 + (score / 100.0)
	$AudioStreamPlayer2D.pitch_scale = new_pitch
	
	
