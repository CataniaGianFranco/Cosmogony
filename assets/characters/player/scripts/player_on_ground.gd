extends "res://assets/characters/player/scripts/player_motion.gd"

func _enter() -> void:
	_player._snap_vector = _player._SNAP_DIRECTION * _player._SNAP_LENGTH

func _update(delta) -> void:
	._update(delta)
	
	if _player.is_on_floor():
		_player._jumps_made = 0
		_player._velocity.y = 0
		_player.ray.enabled = false
		if Input.is_action_just_pressed("ui_jump"):
			emit_signal("finished", "Jump")
		if Input.is_action_just_pressed("ui_down"):
			emit_signal("finished", "Crawl")
	else:
		emit_signal("finished", "Fall")
