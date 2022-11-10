extends "res://assets/characters/player/scripts/player_state.gd"

func _enter() -> void:
	_animation.play("basic_attack")

func _handle_input(event: InputEvent) -> void:
	pass

func _exit() -> void:
	print("Te tomaste el palo del idle")
