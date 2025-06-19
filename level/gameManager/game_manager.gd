extends Node

var score = 500
var level = 1
var multiplySpeed = 0
var playerSpriteIndex = 1
var active_balls = 1
var wide_powerup: bool = false
var wide_powerup_used: bool = false
var double_ball_powerups: int = 0

func addPoints(points):
	score += points
	
func hide_canvas():
	$CanvasLayer/ScoreLabel.hide()
	$CanvasLayer/LevelLabel.hide()
	$CanvasLayer/PowerupLabel.hide()

func show_canvas():
	$CanvasLayer/ScoreLabel.show()
	$CanvasLayer/LevelLabel.show()
	$CanvasLayer/PowerupLabel.show()
	
func _process(delta: float) -> void:
	$CanvasLayer/ScoreLabel.text = "Score: " + str(score)
	$CanvasLayer/LevelLabel.text = "Level: " + str(level)
	
	update_powerup_label()

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
