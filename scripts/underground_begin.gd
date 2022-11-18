extends Area2D

var _in_underground: bool = false

func _ready() -> void:
	pass


func _on_UndergroundBegin_body_entered(_body: Node) -> void:
	if _body.is_in_group("Player") and _in_underground == false:
		$"../Camera"._limit_forest = false
		$"../Player".position.x = 27617
		$"../Player".position.y = 1856
		_in_underground = true
	elif _body.is_in_group("Player") and _in_underground == true:
		$"../Camera"._limit_forest = true
		$"../Player".position.x = 33088
		$"../Player".position.y = 768
