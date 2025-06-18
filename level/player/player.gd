extends CharacterBody2D

#const SPEED = 750.0
@export var SPEED: float = 750.0
@export var scale_multiplier: float = 2.0

@onready var sprite = $Player_Sprite
@onready var collision_shape = $CollisionShape2D
@onready var playerIdle = preload("res://art/players/player1idle.png")
@onready var playerHit = preload("res://art/players/player1hit.png")
@onready var playerRun1 = preload("res://art/players/player1run1.png")
@onready var playerRun2 = preload("res://art/players/player1run2.png")

var runFrame = 0
var runTimer = 0.0
const runFrame_TIME = 0.1
var isHit = false

func _ready() -> void:
	initialize_player_for_game()

func changeSprite(index:int):
	if index == 1:
		$Player_Sprite.texture = playerIdle
	elif index == 2:
		$Player_Sprite.texture = playerHit
	elif index == 3:
		$Player_Sprite.texture = playerRun1
	elif index == 4:
		$Player_Sprite.texture = playerRun2

func changePlayerSprites(index:int):
	if index == 1:
		playerIdle = preload("res://art/players/player1idle.png")
		playerHit = preload("res://art/players/player1hit.png")
		playerRun1 = preload("res://art/players/player1run1.png")
		playerRun2 = preload("res://art/players/player1run2.png")
		changeSprite(1)
	if index == 2:
		playerIdle = preload("res://art/players/player2idle.png")
		playerHit = preload("res://art/players/player2hit.png")
		playerRun1 = preload("res://art/players/player2run1.png")
		playerRun2 = preload("res://art/players/player2run2.png")
		changeSprite(1)
	if index == 3:
		playerIdle = preload("res://art/players/player3idle.png")
		playerHit = preload("res://art/players/player3hit.png")
		playerRun1 = preload("res://art/players/player3run1.png")
		playerRun2 = preload("res://art/players/player3run2.png")
	if index == 4:
		playerIdle = preload("res://art/players/player4idle.png")
		playerHit = preload("res://art/players/player4hit.png")
		playerRun1 = preload("res://art/players/player4run1.png")
		playerRun2 = preload("res://art/players/player4run2.png")


func playerWasHit():
	isHit = true
	changeSprite(2)
	await get_tree().create_timer(0.2).timeout
	isHit = false
	changeSprite(1)

func initialize_player_for_game():
	if GameManager.wide_powerup:
		print("Aktywacja szerokiego gracza na te gre")
		apply_width_inc()
		GameManager.wide_powerup = false

func apply_width_inc():
	scale.x = scale_multiplier

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_collide(velocity * delta)

func _process(delta: float) -> void:
	if isHit:
		return
	var movingLeft = Input.is_action_pressed("ui_left")
	var movingRight = Input.is_action_pressed("ui_right")

	if movingLeft or movingRight:
		if movingLeft:
			$Player_Sprite.flip_h = true
		elif movingRight:
			$Player_Sprite.flip_h = false

		runTimer += delta
		if runTimer >= runFrame_TIME:
			runTimer = 0.0
			runFrame = 1 - runFrame
			if runFrame == 0:
				changeSprite(3)
			else:
				changeSprite(4)
	else:
		changeSprite(1)
		runTimer = 0.0
		runFrame = 0
