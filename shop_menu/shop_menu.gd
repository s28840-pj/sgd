extends Control

const WIDE_POWERUP_COST = 100
const DOUBLE_BALL_POWERUP_COST = 100

const POWERUP_WIDE = "wide"
const POWERUP_DOUBLE_BALL = "double_ball"

@onready var credits_label = $MarginContainer/VBoxContainer/CreditsLabel
@onready var buy_info = $MarginContainer/VBoxContainer/BuyInfo
@onready var wide_buy_button = $MarginContainer/VBoxContainer/WidePowerUp
@onready var db_ball_buy_button = $MarginContainer/VBoxContainer/DoubleBallPowerUp

func _ready() -> void:
	update_credits()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	update_buy_buttons_state()

func update_credits():
	credits_label.text = "Credits: " + str(GameManager.score)
	
func update_buy_buttons_state():
	if GameManager.wide_powerup:
		wide_buy_button.disabled = true
		wide_buy_button.hide()
	if GameManager.double_ball_powerup:
		db_ball_buy_button.disabled = true
		db_ball_buy_button.hide()

func _on_buy_button_pressed(powerup_id: String) -> void:
	var cost = 0
	var is_owned = false
	var powerup_name = ""
	var powerup_manager_variable
	
	match powerup_id:
		POWERUP_WIDE:
			cost=WIDE_POWERUP_COST
			is_owned = GameManager.wide_powerup
			powerup_name = "Wide Power-Up"
			powerup_manager_variable = "wide_powerup"
		POWERUP_DOUBLE_BALL:
			cost = DOUBLE_BALL_POWERUP_COST
			is_owned = GameManager.double_ball_powerup
			powerup_name = "Double Ball Power-Up"
			powerup_manager_variable = "double_ball_powerup"
		_:
			buy_info.text = "Unknown power-up!"
			buy_info.show()
			return
		
	if GameManager.score >= cost:
		GameManager.score -= cost
		GameManager.set(powerup_manager_variable, true)
		
		update_credits()
		buy_info.text = powerup_name + " bought!"
		buy_info.show()
		
		match powerup_id:
			POWERUP_WIDE:
				wide_buy_button.disabled = true
				wide_buy_button.hide()
			POWERUP_DOUBLE_BALL:
				db_ball_buy_button.disabled = true
				db_ball_buy_button.hide()
				
	else:
		buy_info.text = "Not enough credits! Need " + str(cost - GameManager.score) + " more for " + powerup_name + "!"
		buy_info.show()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/menu.tscn")
