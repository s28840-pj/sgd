extends Sprite2D

@export var speed: float = 300.0
var joystick_deadzone: float = 0.2
var using_joystick: bool = false
var prev_mouse_position: Vector2 = Vector2.ZERO
var mouse_move_threshold: float = 2.0

func _process(delta: float) -> void:
	var move_x = Input.get_action_strength("ui_joymouse_right") - Input.get_action_strength("ui_joymouse_left")
	var move_y = Input.get_action_strength("ui_joymouse_down") - Input.get_action_strength("ui_joymouse_up")
	var joystick_active = abs(move_x) > joystick_deadzone or abs(move_y) > joystick_deadzone

	var current_mouse_pos = get_viewport().get_mouse_position()
	var mouse_moved = prev_mouse_position.distance_to(current_mouse_pos) > mouse_move_threshold
	prev_mouse_position = current_mouse_pos

	if mouse_moved:
		using_joystick = false

	if joystick_active:
		using_joystick = true
		var joystick_vector = Vector2(move_x, move_y).normalized() * speed * delta
		global_position += joystick_vector

		var screen_size = get_viewport_rect().size
		global_position.x = clamp(global_position.x, 0, screen_size.x)
		global_position.y = clamp(global_position.y, 0, screen_size.y)
	elif using_joystick:
		pass
	else:
		global_position = current_mouse_pos

	if Input.is_action_just_pressed("ui_accept"):
		simulate_mouse_click()


func simulate_mouse_click():
	var viewport = get_viewport()
	var click_position = global_position

	var input_event = InputEventMouseButton.new()
	input_event.button_index = MOUSE_BUTTON_LEFT
	input_event.pressed = true
	input_event.position = click_position
	input_event.global_position = click_position
	viewport.push_input(input_event)

	input_event = InputEventMouseButton.new()
	input_event.button_index = MOUSE_BUTTON_LEFT
	input_event.pressed = false
	input_event.position = click_position
	input_event.global_position = click_position
	viewport.push_input(input_event)
