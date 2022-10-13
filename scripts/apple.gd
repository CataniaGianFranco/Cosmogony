extends Area2D

func _on_Apple_body_entered(body: Node) -> void:
	GameHandler._score += 5
	GameHandler._score_update()
	GameHandler.damage(10)
	queue_free()
