extends "res://assets/characters/player/scripts/player_on_air.gd"

func _enter() -> void:
	._enter()
	_animation.play("jump")
	_player._velocity.y = -_player.jump_strength

func _update(delta) -> void:
	._update(delta)
	
	_player._velocity.x = _get_direction() * _player.speed
	
	_player._velocity.y += _player.gravity * delta
	
	
	if _player._velocity.y >= 0:
		emit_signal("finished", "Fall")
