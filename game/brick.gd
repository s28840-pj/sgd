class_name Brick

extends RigidBody2D

var hitsNeeded: int = 1
var _health: int

func _ready() -> void:
	_health = hitsNeeded
	
func _process(delta: float) -> void:
	pass
	
func hit():
	_health -= 1
	
	if _health == 0:
		GameManager.addPoints(1)
		$AudioStreamPlayer2D.play()
		$Sprite2D.visible = false
		$Crack.visible = false
		$CollisionShape2D.disabled = true
		var bricksLeft = get_tree().get_nodes_in_group('Brick')
		if bricksLeft.size() == 1:
			get_parent().get_node("Ball").is_active = false
			await get_tree().create_timer(1).timeout
			GameManager.level += 1
			get_tree().reload_current_scene()
		else:
			return
		await get_tree().create_timer(1).timeout
		queue_free()
	elif _health < hitsNeeded:
		$Crack.visible = true
