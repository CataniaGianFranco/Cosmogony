extends "res://assets/characters/player/scripts/player_motion.gd"

func _enter() -> void:
	_player._snap_length.y = 32

func _update(delta) -> void:
	
	._update(delta)
	
	if _player.is_on_floor():
		_player._jumps_made = 0
		_player._velocity.y = 0
		_player.ray.enabled = false
		if Input.is_action_just_pressed("ui_jump"):
			emit_signal("finished", "Jump")
	else:
		emit_signal("finished", "Fall")
