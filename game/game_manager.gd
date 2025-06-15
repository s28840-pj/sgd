extends Node

var score = 0
var level = 1

var audio_player: AudioStreamPlayer2D

func addPoints(points):
	score += points
	if score % 5 == 0:
		get_tree().call_group("Level", "audio_speedup", score)
	
func _process(delta: float) -> void:
	$CanvasLayer/ScoreLabel.text = str(score)
	$CanvasLayer/LevelLabel.text = "Level: "+ str(level)
