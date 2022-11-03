extends Node

onready var _health : float = max_health setget _set_health

export var max_health : float = 100.00

var _score_rune : int = 0
var _name_anim_rune : String = ""
var _active_rune_animation : bool = false

signal health_update(_health)
signal killed()

func _ready() -> void:
	pass

func _score_update() -> void:
	#get_tree().get_nodes_in_group("Score")[0].text = String(_score)
	pass

func damage(amount : float) -> void:
	_set_health(_health - amount)

func kill():
	pass

func _set_health(value : float) -> void:
	var prev_health : float = _health
	_health = clamp(value, 0, max_health)
	if _health != prev_health:
		emit_signal("health_update", _health)
		get_tree().get_nodes_in_group("Health")[0].text = String(_health)
		if _health == 0:
			kill()
			emit_signal("killed")
