class_name hit_box
extends Area2D

export var damage: int = 10

func _init() -> void:
	collision_layer = 2
	collision_mask = 0
