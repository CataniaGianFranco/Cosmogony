extends "res://assets/characters/player/scripts/player_motion.gd"


func _ready() -> void:
	pass

func take_damage(amount : int) -> void:
		_player.get_node("HurtBox").visible = false
		GameHandler._health -= amount
		if GameHandler._health > 0:
			_player._velocity.x = 0.0
			_player._animation_player.play("hurt")
