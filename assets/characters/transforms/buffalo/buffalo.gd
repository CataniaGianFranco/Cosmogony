extends Position2D

func _on_EnemyBuffalo_tree_exited() -> void:
	$AllyBuffalo.visible = true
