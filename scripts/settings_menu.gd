extends VBoxContainer

func _process(_delta: float) -> void:
	full_screen()

func full_screen() -> void:
	if $VideoSettings/CheckBox.pressed == true:
		OS.window_fullscreen = true
		$VideoSettings/CheckBox.text = "On"
	else:
		OS.window_fullscreen = false
		$VideoSettings/CheckBox.text = "Off"
