extends HSlider

@onready var bus_index = AudioServer.get_bus_index("music")

func get_volume() -> float:
	return AudioServer.get_bus_volume_db(bus_index)

func set_volume(volume:float):
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(volume)
	)

func _ready() -> void:
	load_volume_settings()
	value_changed.connect(_on_value_changed)
	
	value = db_to_linear(
		get_volume()
	)
	
func _on_value_changed(value: float) -> void:
	set_volume(value)
	save_volume_settings()

func load_volume_settings():
	var config = ConfigFile.new()
	var err = config.load("user://audio_settings.cfg")
	if err != OK:
		set_volume(0.0)
		return
	
	var volume = config.get_value("audio","music_volume",0.0)
	set_volume(db_to_linear(volume))
	
func save_volume_settings():
	var config = ConfigFile.new()
	config.load("user://audio_settings.cfg")
	config.set_value("audio","music_volume",get_volume())
	config.save("user://audio_settings.cfg")
