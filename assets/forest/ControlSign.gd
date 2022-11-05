extends Area2D

onready var _map_controller := $"../../MapController"

var _interact : bool = false

func _process(delta: float) -> void:
	 _interact = Input.is_action_just_pressed("ui_interact")


func _on_ControlSign_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and _interact:
		if _map_controller.visible == false:
			_map_controller.visible == true
		else:
			_map_controller.visible == false
