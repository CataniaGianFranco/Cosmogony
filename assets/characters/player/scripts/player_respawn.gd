extends "res://assets/characters/player/scripts/player_state.gd"


func _ready() -> void:
	pass
func _enter() -> void:
	._enter()
	if _player._not_move == true:
		_player._velocity.x = 0
		_animation.play("respawn")

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	if _anim_name == "respawn":
		emit_signal("finished", "Idle")

func _exit() -> void:
	_player._not_move = false
