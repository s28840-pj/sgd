extends Node2D

@onready var pause_menu = $Camera2D/Pause_Menu
var paused = false

var columns = 26
var rows = 3
var margin_up = 80
var margin_x = 85
var balls = 0
var bricks = 0

const colors = [
	Color(0.980392, 0.921569, 0.843137, 1),
	Color(0.960784, 0.960784, 0.862745, 1),
	Color(0.564706, 0.933333, 0.564706, 1),
	Color(0.686275, 0.933333, 0.933333, 1)
]

func _ready() -> void:
	GameManager.show_canvas()
	$Player.changePlayerSprites(GameManager.playerSpriteIndex)
	
	setupLevel()

func spawn_ball() -> Ball:
	var ball = Ball.create()
	ball.exited_screen.connect(_on_ball_exit)
	add_child(ball)
	balls += 1
	return ball

func create_brick(fab: GDScript, pos: Vector2) -> void:
	var brick: Brick = fab.create(pos)
	brick.got_hit.connect(_on_Brick_got_hit)
	
	#TODO: add 3rd enemy
	var sprite = brick.get_node('Brick_Sprite') 
	var randomNumberColors = randi_range(0,3)
	if randomNumberColors == 0:
		sprite.modulate = colors[0]
	elif randomNumberColors == 1:
		sprite.modulate = colors[1]
	elif randomNumberColors == 2:
		sprite.modulate = colors[2]
	elif randomNumberColors == 3:
		sprite.modulate = colors[3]
	
	add_child(brick)
	bricks += 1

func setupLevel():
	$themeSong.playing = true
	
	spawn_ball()
	
	rows = 2 + GameManager.level
	
	if rows > 6:
		rows = 6
	
	for r in rows:
		for c in columns:
			
			var randomNumber = randi_range(0,2)
			if randomNumber > 0:
				
				var brickFab: GDScript = Brick
				var random =  randi_range(GameManager.level * 5, 100)
				if GameManager.level > 1 && random > 60:
					brickFab = Tank
				if GameManager.level > 2 && random > 80:
					brickFab = Shooter
				if GameManager.level > 3 && random > 90:
					brickFab = Sniper

				create_brick(brickFab, Vector2(margin_x + (70 * c), margin_up + (70 * r)))

func activate_double_ball() -> void:
	var new_ball = spawn_ball()
	new_ball.name = "Ball_Clone_" + str(Time.get_ticks_msec())
	new_ball.global_position = get_random_ball_position()
	new_ball.is_active = true
	var random_direction_x = randf_range(-1.0, 1.0)
	if abs(random_direction_x) < 0.2: 
		random_direction_x = 0.5 if random_direction_x >= 0 else -0.5
		
	var initial_velocity_y = new_ball.speed
	new_ball.velocity = Vector2(random_direction_x * new_ball.speed, -initial_velocity_y)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
	if Input.is_action_just_pressed("activate_double_ball") && GameManager.double_ball_powerups > 0:
		GameManager.double_ball_powerups -= 1
		activate_double_ball()
	
	GameManager.multiplySpeed = GameManager.score / 20
	if GameManager.multiplySpeed > 0:
		$themeSong.pitch_scale = 1.0 + GameManager.multiplySpeed * 0.005
	else:
		$themeSong.pitch_scale = 1.0
	
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused

func get_random_ball_position() -> Vector2:
	var min_x = 100
	var max_x = 1850
	var y_pos = 500

	return Vector2(randi_range(min_x, max_x), y_pos)

func game_over() -> void:
	get_tree().change_scene_to_file("res://game_over_screen/game_over.tscn")

func _on_Player_got_hit() -> void:
	game_over()

func _on_Brick_got_hit(brick: Brick) -> void:
	bricks -= 1
	if bricks == 0:
		GameManager.level += 1
		if GameManager.level == 11:
			get_tree().change_scene_to_file("res://win_screen/win_screen.tscn")
			return
		get_tree().reload_current_scene()
	else:
		await get_tree().create_timer(0.15).timeout
		brick.queue_free()

func _on_ball_exit() -> void:
	balls -= 1
	if balls == 0:
		game_over()
