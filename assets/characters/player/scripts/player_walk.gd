extends "res://assets/characters/player/scripts/player_on_ground.gd"

func _ready() -> void:
	_player._velocity.y = _player.gravity

func _enter() -> void:
	._enter()
	_animation.play("walk")
	_player._velocity.x = _get_direction() * _player.speed

func _update(delta) -> void:
	._update(delta)
	_player._velocity.x = _get_direction() * _player.speed
	if _player._velocity.x == 0:
		emit_signal("finished", "Idle")
		return
