extends "res://fsm/state.gd"

onready var _player: KinematicBody2D = owner
var _animation: AnimationPlayer
var _sprite: Sprite

func _ready() -> void:
	_sprite = _player.get_node("Sprite")
	_animation = _player.get_node("AnimationPlayer")

func _handle_input(event: InputEvent):
	pass

func _animation_finished():
	pass
