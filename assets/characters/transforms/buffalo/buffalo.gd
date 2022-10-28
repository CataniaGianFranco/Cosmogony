extends Position2D

var _enemy_buffalo_position: Vector2 = Vector2(0,0)
var _buffalo_position: Vector2 = Vector2(0,0)

var _can_change_creature: bool = true 

func _ready() -> void:
	pass

func _on_EnemyBuffalo_tree_exited() -> void:
	$AllyBuffalo.visible = true
	_can_change_creature = false
