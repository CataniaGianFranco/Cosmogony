extends Area2D


func _ready() -> void:
	pass


func _on_Conversation_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and GameHandler._is_action_player == true:
		GameHandler._is_action_player = false
		$"../Player/ControlDialogic".visible = true
		$"../AllySquirrel/ControlDialogic".visible = true
