extends Node2D

var _enemy_buffalo_position: Vector2 = Vector2(0,0)
var _buffalo_position: Vector2 = Vector2(0,0)

var _can_change_creature: bool = true 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if $EnemyBuffalo != null:
		_enemy_buffalo_position = $EnemyBuffalo.position
	elif $EnemyBuffalo == null and _can_change_creature == true:
		$AudioStreamPlayer.play()
		$Buffalo.position = _enemy_buffalo_position
		$Buffalo.visible = true
		_can_change_creature = false

