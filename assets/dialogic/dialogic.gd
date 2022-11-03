extends Control

onready var _rich_text_label : RichTextLabel = $RichTextLabel

export var dialog : Array = [
	'Hola! No veo bien pero se quién eres',
	'estamos en [shake rate=100 level=3]peligro[/shake]',
	'necesitamos de tu ayuda'
]

var _text_speed : float = 0.06
var _dialog_index : int = 0
var _finished : bool = false

func _ready() -> void:
	_rich_text_label.bbcode_text = ""
	load_dialog()

func _process(delta: float) -> void:
	$Next.visible = _finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog() -> void:
	if _dialog_index < dialog.size():
		_finished = false
		_rich_text_label.bbcode_text = dialog[_dialog_index]
		_rich_text_label.percent_visible = 0
		var tween_duration = _text_speed * dialog[_dialog_index].length()
		$Tween.interpolate_property(_rich_text_label, "percent_visible",
		 0, 1, tween_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
	else:
		queue_free()
	_dialog_index += 1


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	_finished = true
