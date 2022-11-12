extends "res://assets/characters/player/scripts/player_motion.gd"

func _enter() -> void:
	_player._snap_length.y = 0
	
func _update(delta) -> void:
	._update(delta)
	_player.ray.enabled = true
	if _player.ray.is_colliding():
		_player._velocity.y = 0
