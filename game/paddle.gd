extends StaticBody2D

@export var default_texture: Texture2D
@export var alternate_texture: Texture2D
@export var speed: int = 600
@export var bounds: Rect2 = Rect2(Vector2(75, 885), Vector2(1725, 145))

func change_sprite() -> void:
	$Sprite2D.texture = alternate_texture
	await get_tree().create_timer(0.1).timeout
	$Sprite2D.texture = default_texture
	
	
	
	

func _physics_process(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var new_position = position + input_vector * speed * delta
	new_position.x = clamp(new_position.x, bounds.position.x, bounds.position.x + bounds.size.x)
	new_position.y = clamp(new_position.y, bounds.position.y, bounds.position.y + bounds.size.y)
	position = new_position 
