extends Area2D

export(String) var name_animation: String = ""
export(SpriteFrames) var frames_rune: SpriteFrames = null

onready var _camera = $"../Camera"

var stone_rune_on: bool = false

func _ready() -> void:
	$AnimatedSprite.frames = frames_rune
	$AnimatedSprite.animation = name_animation

func _on_StoneRune_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and stone_rune_on == false: #and count_run == 5:
		Input.start_joy_vibration(0,0.15,0.15,1)
		$Sprite.visible = false
		$AnimatedSprite.play()
		$AudioStreamPlayer2D.play()
		stone_rune_on = true


func _on_AnimatedSprite_animation_finished() -> void:
	Input.start_joy_vibration(0,0.2,0.2,1.2)
	_camera.shake(1.5)
