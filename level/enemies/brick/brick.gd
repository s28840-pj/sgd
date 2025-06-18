class_name Brick
extends RigidBody2D

static func create(pos: Vector2) -> Brick:
	const scene = preload("res://level/enemies/brick/brick.tscn")
	var instance: Brick = scene.instantiate()
	instance.position = pos
	return instance

var health = 1

func hit() -> void:
	health -= 1
	if health == 0:
		if $Break.visible == true:
			GameManager.addPoints(2)
			$Break.hide()
		else:
			GameManager.addPoints(1)
		
		$Break_Sound.playing = true
		$CPUParticles2D.emitting = true
		
		$Brick_Sprite.hide()
		$CollisionShape2D.disabled = true
		
		GameManager.bricksLeft -= 1
		
		if GameManager.bricksLeft == 0:
			get_parent().get_node("Ball").is_active = false
			GameManager.level += 1
			get_tree().reload_current_scene()
		else:
			await get_tree().create_timer(0.15).timeout
			queue_free()
		
		#var bricksLeft = get_tree().get_nodes_in_group('Bricks')
		#if bricksLeft.size() == 1:
			#get_parent().get_node("Ball").is_active = false
			#GameManager.level += 1
			#get_tree().reload_current_scene()
		#else:
			#await get_tree().create_timer(0.15).timeout
			#queue_free()
	elif health == 1:
		$Break.show()
