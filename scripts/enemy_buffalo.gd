extends Node2D
var _health: int = 20 
onready var _animation_player: AnimationPlayer = $AnimationPlayer 

func _process(delta: float) -> void:
	_animation_player.play("idle")

func take_damage(amount : int) -> void:
	#_animated_sprite.Play("Hurt")
		_health -= amount
		if _health > 0:
			print("Health:", _health)
		else:
			queue_free()
			print("Buffalo is dead.")
