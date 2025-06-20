extends StaticBody2D

func _ready() -> void:
	$Cheat_Zone.disabled = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cheat"):
		var CheatZoneDisabled = $Cheat_Zone.disabled
		var CHeatZoneSprite = $Cheat_Wall.visible
		$Cheat_Zone.disabled = !CheatZoneDisabled
		$Cheat_Wall.visible = !$Cheat_Wall.visible
