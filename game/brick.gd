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
		$Sprite2D.visible = false
		$Crack.visible = false
		$CollisionShape2D.disabled = true

		await get_tree().create_timer(1).timeout
		queue_free()
	elif _health < hitsNeeded:
		$Crack.visible = true
