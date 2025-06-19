extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		body._on_death_zone_body_entered()
