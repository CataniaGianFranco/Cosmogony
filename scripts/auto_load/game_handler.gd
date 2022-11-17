extends Node

var _max_health : int = 5
var _health : int = _max_health

var _score_rune : int = 0
var _name_anim_rune : String = ""
var _active_rune_animation : bool = false
var _is_action_player : bool = true

func _ready() -> void:
	pass

func damage(amount : int) -> void:
	_health -= amount
