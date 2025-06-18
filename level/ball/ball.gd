extends CharacterBody2D

var speed = 230 
#var dir = Vector2.DOWN
var is_active = true
var savedSpeed

func _ready() -> void:
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
				collider.changeSprite(2)
				await get_tree().create_timer(0.2).timeout
				collider.changeSprite(1)
			
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

func gameOver():
	get_tree().change_scene_to_file("res://game_over_screen/game_over.tscn")

func _on_death_zone_body_entered(body: Node2D) -> void:
	gameOver()
