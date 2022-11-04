extends Area2D

export(String) var name_animation: String = ""
export(SpriteFrames) var frames_rune: SpriteFrames = null

onready var _camera = $"../Camera"
onready var _forestCleanRiver := $"../ForestCleanRiver"
onready var _forestCleanWaterFall := $"../ForestCleanWaterFall"

var stone_rune_on: bool = false

var _clean_water : bool = false

func _ready() -> void:
	$AnimatedSprite.frames = frames_rune
	$AnimatedSprite.animation = name_animation

func tween() -> void:
	$Tween.interpolate_property(_forestCleanRiver, "modulate",
	 Color(1,1,1,0),  Color(1,1,1,1), 3.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(_forestCleanWaterFall, "modulate",
	 Color(1,1,1,0),  Color(1,1,1,1), 3.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_StoneRune_body_entered(body: Node) -> void:
	print("Le falta ", 5 - GameHandler._score_rune)
	if body.is_in_group("Player") and stone_rune_on == false and GameHandler._score_rune == 5:
		Input.start_joy_vibration(0,0.15,0.15,1)
		$Sprite.visible = false
		$AnimatedSprite.play()
		$AudioStreamPlayer2D.play()
		stone_rune_on = true

func _on_AnimatedSprite_animation_finished() -> void:
	Input.start_joy_vibration(0,0.2,0.2,1.2)
	_camera.shake(1.5)
	tween()
