extends "res://assets/characters/player/scripts/player_on_ground.gd"

var _direction: Vector2

func _enter() -> void:
	._enter()
	_animation.play("idle")

#func _update(delta) -> void:
#	if _get_direction() != 0:
#		emit_signal("finished", "Walk")

func _handle_input(event: InputEvent):
	_direction.x = int(event.is_action_pressed("ui_right")) - int(event.is_action_pressed("ui_left"))
	
	if _direction.x != 0:
		emit_signal("finished", "Walk")

func _exit() -> void:
	_direction = _player._UP_DIRECTION
