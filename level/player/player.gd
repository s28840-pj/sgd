extends CharacterBody2D

#const SPEED = 750.0
@export var SPEED: float = 750.0
@export var scale_multiplier: float = 2.0

@onready var sprite = $Player_Sprite
@onready var collision_shape = $CollisionShape2D
@onready var player = preload("res://art/player1.png")
@onready var playerhit = preload("res://art/player1hit.png")
@onready var playerIdle = preload("res://art/players/player1idle.png")
@onready var playerHit = preload("res://art/players/player1hit.png")
@onready var playerRun1 = preload("res://art/players/player1run1.png")
@onready var playerRun2 = preload("res://art/players/player1run2.png")

func _ready() -> void:
	initialize_player_for_game()

func changeSprite(index:int):
	if index == 1:
		$Player_Sprite.texture = player
	elif index == 2:
		$Player_Sprite.texture = playerhit

func initialize_player_for_game():
	if GameManager.wide_powerup:
		print("Aktywacja szerokiego gracza na te gre")
		apply_width_inc()
		GameManager.wide_powerup = false

func apply_width_inc():
	scale.x = scale_multiplier

func changePlayerSprites(index:int):
	if index == 1:
		player = preload("res://art/player1.png")
		playerhit = preload("res://art/player1hit.png")
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

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_collide(velocity * delta)
