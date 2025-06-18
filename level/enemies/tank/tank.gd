class_name Tank
extends Brick

static func create(pos: Vector2) -> Tank:
	const scene = preload("res://level/enemies/tank/tank.tscn")
	var instance = scene.instantiate()
	instance.position = pos
	return instance

func _init() -> void:
	health = 2
