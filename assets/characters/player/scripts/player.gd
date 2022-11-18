extends KinematicBody2D

export(float) var speed: float = 600.0
export(float) var jump_strength: float = 1500.0
export(float) var double_jump_strength: float = 1200.0
export(float) var gravity: float = 4500.0
export(AudioStream) var sfx_dash = null
export(AudioStream) var sfx_basic_attack = null
export(AudioStream) var sfx_jump = null

onready var _start_scale: Vector2 = $"Sprite".scale
onready var _animation_player: AnimationPlayer = $"AnimationPlayer"
onready var _weapon: Node2D = $Weapon
onready var _scarf_hit_box: Area2D = $Weapon/ScarfHitBox
onready var _audio_stream_player : AudioStreamPlayer = $AudioStreamPlayer
onready var _sprite: Sprite = $Sprite

const _UP_DIRECTION : Vector2 = Vector2.UP
const _SNAP_DIRECTION: Vector2 = Vector2.DOWN
const _SNAP_LENGTH: float = 32.0
const _SLOPE_THRESHOLD: float = deg2rad(45)
const _MAXIMUM_JUMPS: int = 2
var _is_crawling: bool = false
var _is_lading: bool = false
var ray : RayCast2D
var _not_move: bool = true

var _jumps_made: int = 0
var _velocity: Vector2 = Vector2.ZERO
var _snap_vector: Vector2 = _SNAP_DIRECTION * _SNAP_LENGTH

func _ready() -> void:
	ray = get_node("RayCast2D")
	ray.enabled = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_restart"):
		if GameHandler._health == 0:
			GameHandler._health = 5
		get_tree().reload_current_scene()
	change_animation()

func crawl() -> void:
		var is_crawl: bool = Input.is_action_pressed("ui_down")
		if is_crawl and _jumps_made == 0:
			$CollisionShape2D.disabled = true
			$CollisionShapeCrawl.disabled = false
			_is_crawling = true
		else:
			$CollisionShape2D.disabled = false
			$CollisionShapeCrawl.disabled = true
			_is_crawling = false

func take_damage(amount : int) -> void:
		$HurtBox.visible = false
		GameHandler._health -= amount
		if GameHandler._health > 0: 
				_animation_player.play("hurt")
		else:
			_animation_player.play("exhausted")

func change_animation() -> void:
	if GameHandler._active_rune_animation == true:
		$SpriteFramentRune.visible = true
		$AnimationFragmentRune.play(GameHandler._name_anim_rune)
		GameHandler._active_rune_animation = false

func _on_AnimationFragmentRune_animation_finished(anim_name: String) -> void:
	if anim_name == GameHandler._name_anim_rune:
		$SpriteFramentRune.visible = false
