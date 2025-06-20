extends Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if not MenusMusic.is_playing():
		MenusMusic.play()
	
	#GameManager.level = 1
	#GameManager.score = 0
	
	GameManager.hide_canvas()
	GameManager.load_user_settings()
	
	var config = ConfigFile.new()
	var err = config.load("user://audio_settings.cfg")
	var bus_index = AudioServer.get_bus_index("Master")
	var muted = config.get_value("audio","master_is_muted",false)
	var volume = config.get_value("audio","master_volume",0.0)
	changeMutedVolume(bus_index, muted, db_to_linear(volume))
	bus_index = AudioServer.get_bus_index("music")
	muted = config.get_value("audio","music_is_muted",false)
	volume = config.get_value("audio","music_volume",0.0)
	changeMutedVolume(bus_index, muted, db_to_linear(volume))
	bus_index = AudioServer.get_bus_index("sfx")
	muted = config.get_value("audio","sfx_is_muted",false)
	volume = config.get_value("audio","sfx_volume",0.0)
	changeMutedVolume(bus_index, muted, db_to_linear(volume))
	
func changeMutedVolume(bus_index: int, muted: bool, volume: float):
	AudioServer.set_bus_mute(bus_index,muted)
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(volume)
	)

func _on_play_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	GameManager.level = 1
	GameManager.score = 0
	get_tree().change_scene_to_file("res://select_screen/select_screen.tscn")

func _on_shop_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	get_tree().change_scene_to_file("res://shop_menu/shop_menu.tscn")

func _on_leaderboard_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	get_tree().change_scene_to_file("res://leaderboards/leaderboards.tscn")

func _on_options_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	get_tree().change_scene_to_file("res://options_menu/options_menu.tscn")

func _on_quit_pressed() -> void:
	MenuButtonsSfx.play_button_click()
	get_tree().quit(0)
