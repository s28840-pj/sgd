extends CharacterBody2D

var speed = 230 
#var dir = Vector2.DOWN
var is_active = true
var savedSpeed

var ball_scene = preload("res://level/ball/ball.tscn")

func _ready() -> void:
	speed = speed + (20 * GameManager.level)
	velocity = Vector2(speed * -1, speed)
	savedSpeed = speed
	
	if GameManager.double_ball_powerup:
		create_double_ball()
		GameManager.double_ball_powerup = false

func _physics_process(delta: float) -> void:
	if is_active:
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal())
			if collision.get_collider().has_method("hit"):
				collision.get_collider().hit()
			if collision.get_collider().has_method("changeSprite"):
				collision.get_collider().changeSprite(2)
				await get_tree().create_timer(0.2).timeout
				collision.get_collider().changeSprite(1)
			
		if (velocity.y > 0 and velocity.y < 100):
			velocity.y = -200
		if (velocity.x == 0):
			velocity.x = -200
	if Input.is_action_just_pressed("cheat"):
		if speed == 5000:
			speed = savedSpeed
			velocity = Vector2(speed * -1, speed)
		else:
			speed = 5000
			velocity = Vector2(speed * -1, speed)

func create_double_ball():
	var new_ball = ball_scene.instantiate()
	
	new_ball.name = "Ball_Clone"
	var parent_level = get_parent()
	if parent_level and parent_level.has_method("get_random_ball_position"):
		if parent_level and parent_level.has_method("get_random_ball_position"):
			parent_level.add_child.call_deferred(new_ball)
		new_ball.global_position = parent_level.get_random_ball_position()
	else:
		printerr("blad - nie znaleziono wezla level lub funk. get_random_ball_pos")
	
func gameOver():
	get_tree().change_scene_to_file("res://game_over_screen/game_over.tscn")

func _on_death_zone_body_entered(body: Node2D) -> void:
	gameOver()
