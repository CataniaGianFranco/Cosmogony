extends "res://assets/characters/player/scripts/player_motion.gd"

func _enter() -> void:
	_player._snap.y = 32

func _update(delta) -> void:
	
	._update(delta)
	
	if _player.is_on_floor():
		if Input.is_action_pressed("ui_jump"):
			emit_signal("finished", "Jump")
	else:
		emit_signal("finished", "Fall")
