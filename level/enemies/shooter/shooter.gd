class_name Shooter
extends Brick

static func create(pos: Vector2) -> Brick:
	return __create(preload("res://level/enemies/shooter/shooter.tscn"), pos)

func _get_bullet_transform() -> Transform2D:
	return transform.rotated_local(PI / 2)

func hit() -> void:
	var bullet_dir = _get_bullet_transform()
	var b = Bullet.create(bullet_dir)
	get_parent().add_child(b)
	super()
