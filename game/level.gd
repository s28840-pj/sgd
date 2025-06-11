extends Node2D

@onready var brickObject = preload("res://game/brick.tscn")
@onready var enemyObject = preload("res://game/enemy.tscn")

var columns = 32
var rows = 7
var margin = 50

func _ready() -> void:
	setupLevel()
	
func setupLevel():
	var colors = getColors()
	colors.shuffle()
	for r in rows:
		for c in columns:
			var randomNumber = randi_range(0,2)
			if randomNumber > 0:
				#var newBrick = brickObject.instantiate()
				var newBrick = enemyObject.instantiate()
				add_child(newBrick)
				newBrick.position = Vector2(margin + (68*c), margin + (68*r))
				var sprite = newBrick.get_node('Sprite2D')
				if r <= 9:
					sprite.modulate = colors[0]
				if r < 6:
					sprite.modulate = colors[1]
				if r < 3:
					sprite.modulate = colors[2]
func _process(delta: float) -> void:
	pass

func getColors():
	var Colors = [
		Color( 0, 1, 1, 1 ),
		Color( 0.54, 0.17, 0.89, 1 ),
		Color( 0.68, 1, 0.18, 1 ),
		Color( 1, 1, 1, 1 ),
	]
	return Colors
