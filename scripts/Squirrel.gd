extends Node2D

var _enemy_squirrel_position: Vector2 = Vector2(0,0)
var _squirrel_position: Vector2 = Vector2(0,0)

var _can_change_creature: bool = true 

func _process(delta: float) -> void:
	
	if $EnemySquirrel != null:
		_enemy_squirrel_position = $EnemySquirrel.position
	elif $EnemySquirrel == null and _can_change_creature == true:
		$AllySquirrel.position = _enemy_squirrel_position
		$AllySquirrel.visible = true
		_can_change_creature = false
