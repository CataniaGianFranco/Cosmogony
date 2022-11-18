extends VBoxContainer

func _ready() -> void:
	full_screen()

func _process(_delta: float) -> void:
	full_screen()

func full_screen() -> void:
	if $VideoSettings/CheckBox.pressed == false:
		OS.window_fullscreen = false
		$VideoSettings/CheckBox.text = "Off"
	else:
		OS.window_fullscreen = true
		$VideoSettings/CheckBox.text = "On"
