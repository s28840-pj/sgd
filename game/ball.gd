extends CharacterBody2D

var speed = 225
var dir = Vector2.DOWN
var is_active = true

func _ready() -> void:
	velocity = Vector2(speed * -1, speed)
	
func _physics_process(delta: float) -> void:
	if is_active:
		var collision = move_and_collide(velocity * delta)
		
		if collision:
			var collider = collision.get_collider()
			var collider_index = collision.get_collider_shape_index()
			var normal = collision.get_normal()
			
			if collider.name == "paddle":
				match collider_index:
					0: 
						velocity = velocity.bounce(normal)
					1,2,3:
						velocity = velocity.bounce(normal)
						return
					_:
						print("Unexpected shape index: ", collider_index)
			else:
				velocity = velocity.bounce(normal)
				
			if collider.has_method("hit"):
				collider.hit()
		if velocity.y > 0 and velocity.y < 100:
			velocity.y = -200
		if velocity.x == 0:
			velocity.x = -200

		

func gameOver():
	get_tree().reload_current_scene()

func _on_deathzone_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://game_over_screen/game_over.tscn")
