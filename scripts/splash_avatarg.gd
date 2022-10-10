extends Control

func _on_VideoPlayer_finished() -> void:
	get_tree().call_deferred("change_scene", "res://scenes/startmenu.tscn")
