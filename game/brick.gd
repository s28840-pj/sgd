extends RigidBody2D

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
	
func hit():
	$Sprite2D.visible = false
	$CollisionShape2D.disabled = true
	
	await get_tree().create_timer(1).timeout
	queue_free()
	
