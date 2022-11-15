extends Control

onready var _rich_text_label : RichTextLabel = $Dialogic/RichTextLabel

export var dialog : Array = [
	'¿QUÉ?',
	'[shake rate=100 level=7]¡¡SOY UNA ARDILLA!![/shake]',
	'Olvida, estamos en problema.'
]

var _text_speed : float = 0.06
var _dialog_index : int = 0
var _finished : bool = false

func _ready() -> void:
	_rich_text_label.bbcode_text = ""
	load_dialog()

func _process(_delta: float) -> void:
	$Dialogic/Next.visible = _finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog() -> void:
	if _dialog_index < dialog.size():
		_finished = false
		_rich_text_label.bbcode_text = dialog[_dialog_index]
		_rich_text_label.percent_visible = 0
		var tween_duration = _text_speed * dialog[_dialog_index].length()
		$Dialogic/Tween.interpolate_property(_rich_text_label, "percent_visible",
		 0, 1, tween_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Dialogic/Tween.start()
	else:
		GameHandler._is_action_player = true
		visible = false
		#queue_free()
	_dialog_index += 1


func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	_finished = true
