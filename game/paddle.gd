extends CharacterBody2D

@export var speed: int = 600

func _physics_process(delta):
	# ruszanie sie prawo-lewo
	#velocity = Vector2.ZERO
	#
	#if Input.is_action_pressed("ui_left"):
		#velocity.x -= 1
	#if Input.is_action_pressed("ui_right"):
		#velocity.x +=1
		#
	#move_and_collide(velocity * delta * speed)
	
	#ruszanie tez gora dol
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity *= speed
	
	move_and_slide()
