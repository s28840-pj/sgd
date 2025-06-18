class_name Tank
extends Brick

static func create(pos: Vector2) -> Brick:
	return __create(preload("res://level/enemies/tank/tank.tscn"), pos)

func _init() -> void:
	health = 2
