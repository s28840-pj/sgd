class_name Ball
extends CharacterBody2D

signal exited_screen

static func create() -> Ball:
	var instance = preload("res://level/ball/ball.tscn").instantiate()
	return instance

var speed = 350 
var is_active = false
var savedSpeed
@onready var player: Player = get_tree().get_first_node_in_group('Players')

func _ready() -> void:
	transform = player.transform.translated_local(Vector2(0, -80))
	speed = speed + (20 * GameManager.level)
	velocity = Vector2(speed * -1, speed)
	savedSpeed = speed

func _physics_process(delta: float) -> void:
	if is_active:
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal())
			var collider = collision.get_collider()
			if collider is Brick:
				collider.hit()
			if collider is Player:
				collider._on_Ball_bounced()
		if Input.is_action_just_pressed("cheat"):
			if speed == 5000:
				speed = savedSpeed
				velocity = Vector2(speed * -1, speed)
			else:
				speed = 5000
				velocity = Vector2(speed * -1, speed)
	else:
		var last_frame := global_position
		transform = player.transform.translated_local(Vector2(0, -80))
		if Input.is_action_just_released("throw_ball"):
			is_active = true
			var d := (global_position - last_frame).normalized()
			if d.x == 0:
				d = Vector2(0, -1)
			elif d.x > 0:
				d = d.rotated(-PI / 4)
			else:
				d = d.rotated(PI / 4)
			velocity = d * savedSpeed

func _on_death_zone_body_entered() -> void:
	queue_free()
	exited_screen.emit()
