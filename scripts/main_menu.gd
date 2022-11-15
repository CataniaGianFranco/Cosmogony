extends Control

onready var _video_player = $VideoPlayer
onready var _setting_menu = $SettingsMenu
onready var _video_settings = $SettingsMenu/MainMenuTwo/SettingsMenu/VideoSettings
onready var _audio_settings = $SettingsMenu/MainMenuTwo/SettingsMenu/AudioSettings
onready var _control_settings = $SettingsMenu/MainMenuTwo/SettingsMenu/ControlsSettings
onready var _animation_player = $AnimationPlayer
onready var _start = $Menu/Start

func _ready() -> void:
	_start.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func _process(_delta: float) -> void:
	if !_video_player.is_playing():
		_video_player.play()

func _on_Start_pressed() -> void:
	get_tree().call_deferred("change_scene","res://scenes/World.tscn")

func _on_Settings_pressed() -> void:
	_setting_menu.popup_centered()
	hide_settings()
	_video_settings.show()

func _on_Quit_pressed() -> void:
	get_tree().quit()

func _on_Video_pressed() -> void:
	hide_settings()
	_video_settings.show()

func _on_Audio_pressed() -> void:
	hide_settings()
	_audio_settings.show()

func _on_Controls_pressed() -> void:
	hide_settings()
	_control_settings.show()
	
func hide_settings() -> void:
	_video_settings.hide()
	_audio_settings.hide()
	_control_settings.hide()
	play_animation()

func play_animation() -> void:
	_animation_player.play("settings")
