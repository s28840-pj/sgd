class_name Player
extends CharacterBody2D

const SPEED = 750.0

@onready var playerIdle = preload("res://art/player1idle.png")
@onready var playerHit = preload("res://art/player1hit.png")
@onready var playerRun1 = preload("res://art/player1run1.png")
@onready var playerRun2 = preload("res://art/player1run2.png")

var runFrame = 0
var runTimer = 0.0
const runFrame_TIME = 0.1
var isHit = false

func changeSprite(index:int):
	if index == 1:
		$Player_Sprite.texture = playerIdle
	elif index == 2:
		$Player_Sprite.texture = playerHit
	elif index == 3:
		$Player_Sprite.texture = playerRun1
	elif index == 4:
		$Player_Sprite.texture = playerRun2

func playerWasHit():
	isHit = true
	changeSprite(2)
	await get_tree().create_timer(0.2).timeout
	isHit = false
	changeSprite(1)

func changePlayerSprites(index:int):
	if index == 1:
		playerIdle = preload("res://art/player1idle.png")
		playerHit = preload("res://art/player1hit.png")
		playerRun1 = preload("res://art/player1run1.png")
		playerRun2 = preload("res://art/player1run2.png")
		changeSprite(1)
	#TODO: Add next player characters
	#if index == 2:
		#player = preload("res://art/player2idle.png")
		#playerHit = preload("res://art/player2hit.png")
		#playerRun1 = preload("res://art/player2run1.png")
		#playerRun2 = preload("res://art/player2run2.png")
		#changeSprite(1)

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
