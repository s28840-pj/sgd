class_name Brick

extends RigidBody2D

var hitsNeeded: int

func _ready() -> void:
	hitsNeeded = 1
	
func _process(delta: float) -> void:
	pass
	
func hit():
	hitsNeeded -= 1
	
	if hitsNeeded == 0:
		$Sprite2D.visible = false
		$CollisionShape2D.disabled = true
		
		await get_tree().create_timer(1).timeout
		queue_free()
	
