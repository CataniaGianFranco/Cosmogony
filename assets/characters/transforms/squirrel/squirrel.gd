extends Position2D

func _on_EnemySquirrel_tree_exited() -> void:
	$AllySquirrel.visible = true
