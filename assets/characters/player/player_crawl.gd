extends "res://assets/characters/player/scripts/player_on_ground.gd"

func _enter() -> void:
	._enter()
	_animation.play("crawl")

func _update(delta) -> void:
	#._update(delta)
	if !Input.is_action_pressed("ui_down"):
		_player._velocity.x = 0
		emit_signal("finished", "Idle")
