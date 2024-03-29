extends "res://assets/characters/player/scripts/player_on_air.gd"

func _enter() -> void:
	._enter()
	_player._jumps_made += 1
	_player._velocity.y = -_player.jump_strength
	_animation.play("jump")

func _update(delta) -> void:
	._update(delta)
	_player._velocity.x = _get_direction() * _player.speed
	_player._audio_stream_player.stream = _player.sfx_jump
	_player._audio_stream_player.play()
	if _player._velocity.y >= 0:
		emit_signal("finished", "Fall")
