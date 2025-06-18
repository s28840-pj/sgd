class_name Sniper
extends Shooter

static func create(pos: Vector2) -> Brick:
	return __create(preload("res://level/enemies/sniper/sniper.tscn"), pos)

func _get_bullet_transform() -> Transform2D:
	var player: Player = get_tree().get_first_node_in_group("Players")
	var a = (player.global_position - global_position).angle()
	return transform.rotated_local(a)
