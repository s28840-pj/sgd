class_name Shooter
extends Brick

static func create(pos: Vector2) -> Shooter:
	const scene = preload("res://level/enemies/shooter/shooter.tscn")
	var instance = scene.instantiate()
	instance.position = pos
	return instance

func hit() -> void:
	var bullet_dir = transform.rotated_local(PI / 2)
	var b = Bullet.create(bullet_dir)
	get_parent().add_child(b)
	super()
