extends Node2D
var _health: int = 20 
onready var _animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	_animation_player.play("idle")

func take_damage(amount : int) -> void:
		_health -= amount
		if _health > 0:
			_animation_player.play("hurt")
		else:
			_animation_player.play("exhausted")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "hurt":
		_animation_player.play("idle")
	if anim_name == "exhausted":
		$AudioStreamPlayer.play()
		$Timer.start()


func _on_Timer_timeout() -> void:
	queue_free()
