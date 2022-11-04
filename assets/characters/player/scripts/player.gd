extends KinematicBody2D

onready var _audio_stream_player : AudioStreamPlayer = $AudioStreamPlayer
onready var _sprite : Sprite = $Sprite
#Variables públicas.
export(float) var speed: float = 600.0
export(float) var jump_strength: float = 1500.0
export(int) var maximum_jumps: int = 2
export(float) var double_jump_strength: float = 1200.0
export(float) var gravity: float = 4500.0
export(AudioStream) var sfx_dash = null
export(AudioStream) var sfx_basic_attack = null
export(AudioStream) var sfx_jump = null

#Variables privadas.
var _jumps_made: int = 0
var _velocity: Vector2 = Vector2.ZERO
var _is_attacking: bool = false
var _is_dashing: bool = false
var _is_jumping: bool = false
var _is_crawling: bool = false
var _is_lading: bool = false

const _UP_DIRECTION : Vector2 = Vector2.UP

onready var _start_scale: Vector2 = $"Sprite".scale
onready var _animationPlayer: AnimationPlayer = $"AnimationPlayer"
onready var _scarf_hit_box : Area2D = $ScarfHitBox
#Máquina de estados
enum _State {IDLE, WALK, JUMP, DOUBLE_JUMP, FALL, ATTACK, DASH, CRAWL, CRAWLING}
var _current_state: int
var _current_animation: String
var _new_animation: String

func _ready() -> void:
	travel_to(_State.IDLE)
	get_node("ScarfHitBox/ScarfCollision").disabled = true #Encontrar una solución sin necesidad de pedirle ya que comienza activado.

func _process(delta: float) -> void:
	var fps = Engine.get_frames_per_second()
	var lerp_interval = _velocity / fps
	var lerp_position = global_transform.origin + lerp_interval
	
	if fps > 60:
		_sprite.set_as_toplevel(true)
		_sprite.global_transform.origin = _sprite.global_transform.origin.linear_interpolate(lerp_position, 50 * delta)
	else:
		_sprite.global_transform = global_transform
		_sprite.set_as_toplevel(false)
		
	change_animation()
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	
	move()
	jump()
	attack()
	dash()
	crawl()
	state_machine()
	_velocity = move_and_slide(_velocity, _UP_DIRECTION)
	
func travel_to(new_state : int) -> void:
	_current_state = new_state
	match _current_state:
		_State.IDLE:
			_new_animation = "idle"
		_State.WALK:
			_new_animation = "walk"
		_State.JUMP:
			_new_animation = "jump"
		_State.DOUBLE_JUMP:
			_new_animation = "double_jump"
		_State.FALL:
			_new_animation = "fall"
		_State.ATTACK:
			_new_animation = "basic_attack"
		_State.DASH:
			_new_animation = "dash"
		_State.CRAWL:
			_new_animation = "crawl"
		_State.CRAWLING:
			_new_animation = "crawling"

func state_machine() -> void:
	if _current_animation != _new_animation:
		_current_animation = _new_animation
		_animationPlayer.play(_current_animation)
	if is_on_floor():
		if _current_state == _State.IDLE and _velocity.x != 0:
			travel_to(_State.WALK)
		if _current_state == _State.WALK and _velocity.x == 0:
			travel_to(_State.IDLE)
		if _current_state == _State.FALL and _velocity.x == 0:
			travel_to(_State.IDLE)
		if _current_state == _State.FALL and _velocity.x != 0:
			travel_to(_State.WALK)
		if _current_state == _State.IDLE and _is_attacking == true and _is_dashing == false:
			travel_to(_State.ATTACK)
		if _current_state == _State.WALK and _is_attacking == true and _is_dashing == false:
			travel_to(_State.ATTACK)
		if _current_state == _State.ATTACK and _is_attacking == false:
			travel_to(_State.IDLE)
		if _current_state == _State.IDLE and _is_dashing == true and _is_attacking == false:
			travel_to(_State.DASH)
		if _current_state == _State.WALK and _is_dashing == true and _is_attacking == false:
			travel_to(_State.DASH)
		if _current_state == _State.DASH and _is_dashing == false:
			travel_to(_State.IDLE)
		if _current_state == _State.IDLE and _is_crawling == true:
			travel_to(_State.CRAWL)
		if _current_state == _State.CRAWL and _is_crawling == false:
			travel_to(_State.IDLE)
		if _current_state == _State.CRAWL and _is_crawling == true and (_velocity.x > 0 or _velocity.x < 0):
			travel_to(_State.CRAWLING)
		if _current_state == _State.CRAWLING and _is_crawling == false and _velocity.x == 0:
			travel_to(_State.IDLE)
		if _current_state == _State.CRAWLING and _is_crawling == true and _velocity.x == 0:
			travel_to(_State.CRAWL)
		if _current_state == _State.CRAWLING and _is_crawling == false and (_velocity.x > 0 or _velocity.x < 0):
			travel_to(_State.WALK)
		if _current_state == _State.WALK and _is_crawling == true and (_velocity.x > 0 or _velocity.x < 0):
			travel_to(_State.CRAWLING)
	else:
		if _current_state == _State.IDLE and _velocity.y < 0:
			travel_to(_State.JUMP)
		if _current_state == _State.WALK and _velocity.y < 0:
			travel_to(_State.JUMP)
		if _current_state == _State.JUMP and _velocity.y > 0:
			travel_to(_State.FALL)
		if _current_state == _State.FALL and _jumps_made == 2:
			travel_to(_State.DOUBLE_JUMP)
		if _current_state == _State.DOUBLE_JUMP and _velocity.y > 0 and _jumps_made == 2:
			travel_to(_State.FALL)
		if _current_state == _State.WALK and _velocity.y > 0:
			travel_to(_State.FALL)
		if _current_state == _State.IDLE and _velocity.y > 0:
			travel_to(_State.FALL)

func move() -> void:
	var _horizontal_direction: float = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	
	if _is_attacking == false and _is_dashing == false:
		_velocity.x = _horizontal_direction * speed
		if _velocity.x > 0:
			$Sprite.flip_h = false
			_scarf_hit_box.scale.x = 1
		elif _velocity.x < 0:
			$Sprite.flip_h = true
			_scarf_hit_box.scale.x = -1
		else:
			_velocity.x = 0

func attack() -> void:
	var is_basic_attack: bool = Input.is_action_just_pressed("ui_basic_attack")
	if is_basic_attack and _is_attacking == false:
		_is_attacking = true
		_velocity.x = 0
		Input.start_joy_vibration(0,0.08,0.08,0.2)
		$AudioStreamPlayer.stream = sfx_basic_attack
		$AudioStreamPlayer.play()

func dash() -> void:
	var is_dashing: bool = Input.is_action_just_pressed("ui_dash")
	if is_dashing and _is_dashing == false:
		_is_dashing = true
		if $Sprite.flip_h == false:
			_velocity.x += 250
		else:
			_velocity.x -= 250
		Input.start_joy_vibration(0,0.1,0.1,0.3)
		_audio_stream_player.stream = sfx_dash
		_audio_stream_player.play()

func jump() -> void:
	var is_jumping: bool = Input.is_action_just_pressed("ui_jump")
	var is_double_jumping: bool = Input.is_action_just_pressed("ui_jump")
	var is_jump_cancelled: float = Input.is_action_just_released("ui_jump")
	
	if is_on_floor():
		_jumps_made = 0
		_is_lading = true
		if is_jumping and _is_crawling == false:
			_jumps_made += 1
			_velocity.y = -jump_strength
			_audio_stream_player.stream = sfx_jump
			_audio_stream_player.play()
	else:
		if is_double_jumping:
			_jumps_made += 1;
			#AudioStreamPlayer.stream = sfx_jump
			_audio_stream_player.play()
			if _jumps_made <= maximum_jumps:
				_velocity.y = -jump_strength
		if is_jump_cancelled:
			_velocity.y = 0.0

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

func change_animation() -> void:
	if GameHandler._active_rune_animation == true:
		$SpriteFramentRune.visible = true
		$AnimationFragmentRune.play(GameHandler._name_anim_rune)
		GameHandler._active_rune_animation = false

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "basic_attack":
		_is_attacking = false
	if anim_name == "dash":
		_is_dashing = false

func _on_AnimationFragmentRune_animation_finished(anim_name: String) -> void:
	if anim_name == GameHandler._name_anim_rune:
		$SpriteFramentRune.visible = false
