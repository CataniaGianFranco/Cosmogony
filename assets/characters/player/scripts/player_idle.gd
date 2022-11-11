extends "res://assets/characters/player/scripts/player_on_ground.gd"

var _direction: Vector2

func _enter() -> void:
	._enter()
	_player._velocity.x = 0
	_animation.play("idle")

func _update(delta) -> void:
	._update(delta)
	if _get_direction() != 0:
		emit_signal("finished", "Walk")

func _exit() -> void:
	_direction = Vector2.ZERO
