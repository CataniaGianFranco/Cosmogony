extends Camera2D

onready var _player  = get_tree().get_nodes_in_group("Player")[0]
export(float, 0 ,1) var decay: float = 0.8
export var max_offset: Vector2 = Vector2(80,80)
export var max_roll: float = 0.1

onready var _noise: OpenSimplexNoise = OpenSimplexNoise.new()

var _limit_forest: bool = true
var _trauma: float = 0.0
var _max_trauma: float = 1.0
var _noise_y: float = 0.0

func _ready() -> void:
	randomize()
	_noise.seed = randi()
	_noise.period = 3
	
func _process(delta: float) -> void:
	global_position.x = _player.global_position.x + sin(OS.get_ticks_msec() * 64)
	if _limit_forest == true:
		limit_top = 0
		limit_left = 0
		limit_right = 39800
		limit_bottom = 1080
	else:
		limit_top = 1090
		limit_left = 27070
		limit_right = 33880
		limit_bottom = 2139
		
		global_position.y = _player.global_position.y + sin(OS.get_ticks_msec() * 64)
	if decay:
		_trauma = max(_trauma - (decay * delta), 0)
		start_shake()

func shake(amount: float) -> void:
	_trauma = min(_trauma + amount, 1.0)

func start_shake()-> void:
	var amount: float = pow(_trauma, _max_trauma)
	_noise_y += 1
	rotation = max_roll * amount * _noise.get_noise_2d(_noise.seed, _noise_y)
	offset.x = max_offset.x * amount * _noise.get_noise_2d(_noise.seed * 2, _noise_y)
	offset.y = max_offset.y * amount * _noise.get_noise_2d(_noise.seed * 3, _noise_y)
