extends Control

onready var _animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	_animation.play("fade_in")
	yield(get_tree().create_timer(4.26), "timeout")
	_animation.play("fade_out")
	yield(get_tree().create_timer(2.56), "timeout")
	get_tree().call_deferred("change_scene", "res://scenes/MainMenu.tscn")
