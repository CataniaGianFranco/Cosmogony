extends "res://fsm/state.gd"

onready var _player: KinematicBody2D = owner
var _animation: AnimationPlayer
var _sprite: Sprite
var _raycast: RayCast2D

func _ready() -> void:
	_sprite = _player.get_node("Sprite")
	_animation = _player.get_node("AnimationPlayer")
	_raycast = _player.get_node("RayCast2D")

func _handle_input(_event: InputEvent):
	pass

func _animation_finished():
	pass
