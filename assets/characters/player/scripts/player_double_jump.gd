extends "res://assets/characters/player/scripts/player_on_air.gd"

func _enter() -> void:
	._enter()
	if _player._jumps_made < _player._MAXIMUM_JUMPS:
		_player._jumps_made += 1
		_player._velocity.y = -_player.jump_strength
		_animation.play("double_jump")

func _update(delta) -> void:
	._update(delta)
	_player._velocity.x = _get_direction() * _player.speed
	if _player._velocity.y >= 0:
		emit_signal("finished", "Fall")

func _exit() -> void:
	_player._velocity = Vector2.ZERO
