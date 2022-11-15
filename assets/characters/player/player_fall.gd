extends "res://assets/characters/player/scripts/player_on_air.gd"

func _enter() -> void:
	_animation.play("fall")

func _update(delta) -> void:
	._update(delta)
	_player._velocity.x = _get_direction() * _player.speed
	_player._velocity.y += _player.gravity * delta
	
	if _player.is_on_floor():
		if _player._velocity.x == 0:
			emit_signal("finished", "Idle")
		else:
			emit_signal("finished", "Walk")

func _exit() -> void:
	_player._velocity = Vector2.ZERO
