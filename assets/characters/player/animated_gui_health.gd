extends AnimatedSprite

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	_cheange_health()

func _cheange_health() -> void:
	var _current_health: int = GameHandler._health
	match _current_health:
		1:
			animation = "health_5"
		2:
			animation = "health_25"
		3:
			animation = "health_50"
		4:
			animation = "health_75"
		5:
			animation = "health_100"
