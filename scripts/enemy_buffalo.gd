extends Node2D
var _health: int = 20 
onready var _animated_sprite: AnimatedSprite = $AnimatedSprite 

func take_damage(amount : int) -> void:
	#_animated_sprite.Play("Hurt")
		_health -= amount
		if _health > 0:
			print("Health:", _health)
		else:
			queue_free()
			print("Buffalo is dead.")
