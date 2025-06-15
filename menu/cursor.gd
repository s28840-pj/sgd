extends Sprite2D

@export var speed: float = 300.0
var joystick_deadzone: float = 0.2
var using_joystick: bool = false

func _process(delta: float) -> void:
	var move_x = Input.get_action_strength("ui_joymouse_right") - Input.get_action_strength("ui_joymouse_left")
	var move_y = Input.get_action_strength("ui_joymouse_down") - Input.get_action_strength("ui_joymouse_up")
	
	if abs(move_x) > joystick_deadzone or abs(move_y) > joystick_deadzone:
		using_joystick = true
		var joystick_vector = Vector2(move_x, move_y) * speed * delta
		global_position += joystick_vector
		
		var screen_size = get_viewport_rect().size
		global_position.x = clamp(global_position.x, 0, screen_size.x)
		global_position.y = clamp(global_position.y, 0, screen_size.y)
	elif using_joystick:
		using_joystick=false
	else:
		global_position = get_viewport().get_mouse_position()
	
	
	print("Joystick X: ", move_x, ", Joystick Y: ", move_y)
	
	
