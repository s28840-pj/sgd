class_name Enemy

extends Brick

func _ready() -> void:
	hitsNeeded = 2

func hit() -> void:
	super()
	if hitsNeeded == 1:
		$Crack.visible = true
	else:
		$Crack.visible = false
