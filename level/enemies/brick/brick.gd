class_name Brick
extends RigidBody2D

signal got_hit

static func create(pos: Vector2) -> Brick:
	return __create(preload("res://level/enemies/brick/brick.tscn"), pos)

static func __create(scene: Resource, pos: Vector2) -> Brick:
	var instance = scene.instantiate() as Brick
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
		
		got_hit.emit(self)
		
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
