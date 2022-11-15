extends CanvasLayer

var _is_pause: bool = false

func _ready() -> void:
	pause_mode = Node.PAUSE_MODE_PROCESS

func _process(delta: float) -> void:
	if _is_pause == false and Input.is_action_just_pressed("ui_pause"):
		get_tree().paused = !get_tree().paused
		get_child(0).visible = get_tree().paused
		_is_pause = true
		get_tree().paused = true
	elif _is_pause == true and Input.is_action_just_pressed("ui_pause"):
		get_tree().paused = false
		get_tree().paused = get_tree().paused
		get_child(0).visible = get_tree().paused
		_is_pause = false


func _on_Main_menu_pressed() -> void:
	get_child(0).visible = false
	get_tree().paused = false
	get_tree().call_deferred("change_scene", "res://scenes/MainMenu.tscn")


func _on_Quit_pressed() -> void:
	get_tree().quit()


func _on_HSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear2db(value))
	AudioServer.set_bus_mute(1, value < 0.01)
