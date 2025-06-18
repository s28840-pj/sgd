extends CharacterBody2D

const SPEED = 1000.0

@onready var player = preload("res://art/player1.png")
@onready var playerhit = preload("res://art/player1hit.png")

func changeSprite(index:int):
	if index == 1:
		$Player_Sprite.texture = player
	elif index == 2:
		$Player_Sprite.texture = playerhit

func changePlayerSprites(index:int):
	if index == 1:
		player = preload("res://art/player1.png")
		playerhit = preload("res://art/player1hit.png")
		changeSprite(1)
	#TODO: Add next player characters
	#if index == 2:
		#player = preload("res://art/player2.png")
		#playerhit = preload("res://art/player2hit.png")
		#changeSprite(1)

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
