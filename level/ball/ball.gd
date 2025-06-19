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


func create_double_ball():
	var parent_level = get_parent()

	var new_ball = Ball.create()
	new_ball.name = "Ball_Clone_" + str(Time.get_ticks_msec())
	parent_level.spawn_ball(new_ball)
	new_ball.global_position = parent_level.get_random_ball_position()
	new_ball.is_active = true
	var random_direction_x = randf_range(-1.0, 1.0)
	if abs(random_direction_x) < 0.2: 
		random_direction_x = 0.5 if random_direction_x >= 0 else -0.5
		
	var initial_velocity_y = new_ball.speed
	new_ball.velocity = Vector2(random_direction_x * new_ball.speed, -initial_velocity_y)

func _on_death_zone_body_entered() -> void:
	queue_free()
	exited_screen.emit()
