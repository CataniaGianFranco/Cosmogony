extends KinematicBody2D

var _health: int = 30 
onready var _animation_player: AnimationPlayer = $AnimationPlayer 

func _process(delta: float) -> void:
	_animation_player.play("idle")

func take_damage(amount : int) -> void:
		_health -= amount
		if _health > 0:
			print("Health:", _health)
			_animation_player.play("hurt")
		else:
			
			queue_free()
			print("Buffalo is dead.")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "hurt":
		_animation_player.play("idle")
