extends "res://assets/characters/player/scripts/player_state.gd"

func _ready() -> void:
	pass

func _get_direction() -> int:
	var _direction = (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
 
	if _direction != 0:
		_sprite.flip_h = _direction < 0
	return _direction

func _update(_delta: float):
	_player.move_and_slide_with_snap(_player._velocity, _player._snap_vector, _player._UP_DIRECTION, true, 4, _player._SLOPE_THRESHOLD).y
	_player._velocity.y += _player.gravity * _delta

func _handle_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("ui_basic_attack"):
		emit_signal("finished", "Attack")
