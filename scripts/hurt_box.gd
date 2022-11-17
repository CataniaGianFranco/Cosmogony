class_name hurt_box
extends Area2D


func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(_hitBox: hit_box) -> void:
	if _hitBox == null:
		return
	
	if owner.has_method("take_damage"):
		owner.take_damage(_hitBox.damage)

	if owner.get_node("PlayerFSM/Hurt").has_method("take_damage"):
		owner.get_node("PlayerFSM/Hurt").take_damage(_hitBox.damage)
