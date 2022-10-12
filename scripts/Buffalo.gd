extends Node2D

onready var _animation_player: AnimationPlayer = $AnimationPlayer

func _process(delta: float) -> void:
	_animation_player.play("idle")
