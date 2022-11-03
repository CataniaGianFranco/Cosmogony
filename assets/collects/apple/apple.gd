extends Area2D

var _get_apple: bool = true

func _on_Apple_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and _get_apple:
		$Sprite.visible = false
		_get_apple = false
		$AudioStreamPlayer2D.play()

func _on_AudioStreamPlayer2D_finished() -> void:
	queue_free()
