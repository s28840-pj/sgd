extends CPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(lifetime).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
