extends Area2D

var _change_conversation : bool = false

func _process(_delta: float) -> void:
	if _change_conversation == true and $"../Player/ControlDialogic".visible == false:
		$"../AllySquirrel/ControlDialogic".visible = true
		_change_conversation = false

func _on_Conversation_body_entered(_body: Node) -> void:
	if _body.is_in_group("Player") and GameHandler._is_action_player == true:
		GameHandler._is_action_player = false
		$"../Player/ControlDialogic".visible = true
		_change_conversation = true
		$CollisionShape2D.queue_free()
