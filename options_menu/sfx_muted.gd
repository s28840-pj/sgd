extends CheckButton

@onready var button = $"."
@onready var bus_index = AudioServer.get_bus_index("sfx")

func mute_audio(mute_it:bool):
	AudioServer.set_bus_mute(bus_index, mute_it)

func is_audio_muted() -> bool:
	return AudioServer.is_bus_mute(bus_index)

func toogle_mute():
	mute_audio(!is_audio_muted())

func _ready() -> void:
	load_mute_settings()
	if is_audio_muted():
		button.button_pressed = true
	else:
		button.button_pressed = false

func _on_pressed() -> void:
	toogle_mute()
	save_mute_settings()

func load_mute_settings():
	var config = ConfigFile.new()
	var err = config.load("user://audio_settings.cfg")
	if err != OK:
		mute_audio(false)
		return
	
	var is_muted = config.get_value("audio","sfx_is_muted",false)
	mute_audio(is_muted)
	
func save_mute_settings():
	var config = ConfigFile.new()
	config.load("user://audio_settings.cfg")
	config.set_value("audio","sfx_is_muted",is_audio_muted())
	config.save("user://audio_settings.cfg")
