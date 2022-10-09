extends Camera2D

onready var _player  = get_tree().get_nodes_in_group("Player")[0]

func _process(delta: float) -> void:
	global_position.x = _player.global_position.x + sin(OS.get_ticks_msec() * 64)
