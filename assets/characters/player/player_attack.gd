extends "res://assets/characters/player/scripts/player_motion.gd"

func _enter() -> void:
	if _player._snap_vector.y > 0: 
		_animation.play("basic_attack")
	else:
		_animation.play("basic_attack_on_air")
	
	_player._weapon._set_scarf()

func _update(delta) -> void:
	._update(delta)
	_player._velocity.x = _get_direction() * _player.speed
	_player._audio_stream_player.stream = _player.sfx_basic_attack
	_player._audio_stream_player.play()
	Input.start_joy_vibration(0,0.02,0.02,0.2)
func _exit() -> void:
	pass

func _animation_finished() -> void:
	emit_signal("finished", "Idle")
