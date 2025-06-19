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
	if GameManager.double_ball_powerups:
		db_ball_buy_button.text = "Double balls: " + str(GameManager.double_ball_powerups)
		pass

func _on_buy_button_pressed(powerup_id: String) -> void:
	MenuButtonsSfx.play_button_click()
	var cost = 0
	var is_already_activated: bool = false
	var powerup_name = ""
	
	match powerup_id:
		POWERUP_WIDE:
			cost=WIDE_POWERUP_COST
			if GameManager.wide_powerup:
				is_already_activated = true
				
			powerup_name = "Wide Power-Up"
		POWERUP_DOUBLE_BALL:
			cost = DOUBLE_BALL_POWERUP_COST
			
			powerup_name = "Double Ball Power-Ups"
		_:
			buy_info.text = "Unknown power-up!"
			buy_info.show()
			return
		
	if is_already_activated:
		buy_info.text = powerup_name + " already activated!"
		buy_info.show()
		return
	
	if GameManager.score >= cost:
		GameManager.score -= cost
		
		match powerup_id:
			POWERUP_WIDE:
				GameManager.wide_powerup = true
				wide_buy_button.disabled = true
				wide_buy_button.hide()
			POWERUP_DOUBLE_BALL:
				GameManager.double_ball_powerups += 1
				
		update_credits()
		buy_info.text = powerup_name + " bought!"
		buy_info.show()
		
	else:
		buy_info.text = "Not enough credits! Need " + str(cost - GameManager.score) + " more for " + powerup_name + "!"
		buy_info.show()

func _on_back_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	get_tree().change_scene_to_file("res://menu/menu.tscn")
