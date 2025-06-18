extends Node

var score = 500
var level = 1
var multiplySpeed = 0
var playerSpriteIndex = 1
var wide_powerup: bool = false
var double_ball_powerup: bool = false
var bricksLeft

func addPoints(points):
	score += points
	
func hide_canvas():
	$CanvasLayer/ScoreLabel.hide()
	$CanvasLayer/LevelLabel.hide()

func show_canvas():
	$CanvasLayer/ScoreLabel.show()
	$CanvasLayer/LevelLabel.show()
	
func _process(delta: float) -> void:
	$CanvasLayer/ScoreLabel.text = "Score: " + str(score)
	$CanvasLayer/LevelLabel.text = "Level: " + str(level)
