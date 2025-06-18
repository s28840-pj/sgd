class_name Bullet
extends Area2D

static func create(trans: Transform2D) -> Bullet:
	const scene = preload("res://level/enemies/shooter/bullet.tscn")
	var instance = scene.instantiate()
	instance.transform = trans
	return instance

var speed = 550

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body: Node2D) -> void:
	if body is Player:
		queue_free()

func _on_Bullet_area_entered(area: Area2D) -> void:
	queue_free()
