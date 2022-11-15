extends Node2D

onready var _player: KinematicBody2D = owner

func _ready() -> void:
	$ScarfHitBox/ScarfCollision.disabled = true

func _set_scarf():
	var _direction = -1 if _player._scarf_hit_box.scale.x else 1
	if _player._sprite.flip_h == false:
		_player._scarf_hit_box.scale.x = 1
	else:
		_player._scarf_hit_box.scale.x = -1

func _on_ScarfHitBox_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		print(body.name)
