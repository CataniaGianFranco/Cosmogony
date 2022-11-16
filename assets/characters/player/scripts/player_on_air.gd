extends "res://assets/characters/player/scripts/player_motion.gd"

func _enter() -> void:
	_player._snap_vector.y = 0.0
	
func _update(delta) -> void:
	._update(delta)
	if !_player.is_on_floor():
		if Input.is_action_just_pressed("ui_jump") and _player._jumps_made < _player._MAXIMUM_JUMPS:
			emit_signal("finished", "DoubleJump")
	_player.ray.enabled = true
	if _player.ray.is_colliding():
		_player._velocity.y = 0
