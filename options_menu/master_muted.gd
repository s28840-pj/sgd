extends CheckButton

@onready var button = $"."

var bus_index = AudioServer.get_bus_index("Master")

func _ready() -> void:
	if AudioServer.is_bus_mute(bus_index):
		button.button_pressed = true
	else:
		button.button_pressed = false

func _on_pressed() -> void:
	AudioServer.set_bus_mute(bus_index, !AudioServer.is_bus_mute(bus_index))
