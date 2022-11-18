class_name hit_box
extends Area2D

export var damage: int = 1

#func _init() -> void:
#	collision_layer = 2
#	collision_mask = 0

func _on_hit_box_body_entered(_body: Node) -> void:
	if _body.is_in_group("Player"):
		GameHandler.damage(damage)
