extends StaticBody2D

@export var speed: int = 600
@export var bounds: Rect2 = Rect2(Vector2(110, 885), Vector2(1650, 180))

func _physics_process(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var new_position = position + input_vector * speed * delta
	new_position.x = clamp(new_position.x, bounds.position.x, bounds.position.x + bounds.size.x)
	new_position.y = clamp(new_position.y, bounds.position.y, bounds.position.y + bounds.size.y)
	position = new_position 
