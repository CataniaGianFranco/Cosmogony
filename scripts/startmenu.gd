extends Control

onready var _setting_menu = $SettingsMenu
onready var _video_settings = $SettingsMenu/MainMenu2/SettingsContainer/VideoSettings
onready var _audio_settings = $SettingsMenu/MainMenu2/SettingsContainer/AudioSettings
onready var _control_settings = $SettingsMenu/MainMenu2/SettingsContainer/ControlsSettings
onready var _animation_player = $AnimationPlayer
onready var _start_btn = $MainMenu/Start

func _ready() -> void:
	_start_btn.grab_focus()

func _on_Start_pressed() -> void:
	get_tree().call_deferred("change_scene","res://scenes/Main.tscn")

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
