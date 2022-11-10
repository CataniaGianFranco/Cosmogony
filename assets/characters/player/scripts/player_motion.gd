extends "res://assets/characters/player/scripts/player_state.gd"


func _ready() -> void:
	pass

func _get_direction() -> int:
	var _direction = (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
 
	if _direction != 0:
		_sprite.flip_h = _direction < 0
	return _direction

func _update(delta):
	_player.move_and_slide_with_snap(_player._velocity, _player._snap, _player._UP_DIRECTION)
