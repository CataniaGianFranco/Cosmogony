extends KinematicBody2D

var _health: int = 20

const MAX_SPEED : float = 100.0
const GRAVITY : float = 25.0

var _motion : Vector2 = Vector2.ZERO
var _active : bool = false

onready var _animation_player: AnimationPlayer = $AnimationPlayer
onready var _sprite : Sprite = $Sprite

func _ready() -> void:
	_sprite.scale.x = -1
	_motion.x = MAX_SPEED

func _physics_process(delta: float) -> void:
	if _active == true:
		_motion.y += GRAVITY
		flip()
		_motion = move_and_slide(_motion)

func next_to_left_wall() -> bool:
	return $LeftRay.is_colliding()
func next_to_right_wall() -> bool:
	return $RightRay.is_colliding()
func floor_detection() -> bool:
	return $Sprite/FloorDetection.is_colliding()

func flip() -> void:
	if next_to_right_wall() or next_to_left_wall() or !floor_detection():
		_motion.x *= -1
		_sprite.scale.x *= -1 

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

func _on_VisibilityNotifier2D_screen_entered() -> void:
	_active = true
	_animation_player.play("walk")
