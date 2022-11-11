extends Node2D

func _ready() -> void:
	pass

func _on_ScarfHitBox_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		print(body.name)
