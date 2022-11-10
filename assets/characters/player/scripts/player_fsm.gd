extends "res://fsm/fsm.gd"


func _ready() -> void:
	_initialize()

func _input(event: InputEvent) -> void:
	_current_state._handle_input(event)
