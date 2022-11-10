extends Node

var _current_state
var _states_map: Dictionary
var _states_stack: Array

export(String) var _initial_state

func _ready() -> void:
	for i in get_children():
		_states_map[i.name] = i
		i.connect("finished", self, "_change_state")

func _initialize():
	_states_stack.push_front(_states_map[_initial_state])
	_current_state = _states_stack[0]
	_current_state._enter()

func _physics_process(delta: float) -> void:
	_current_state._update(delta)

func _change_state(state_name: String):
	_current_state._exit()
	_states_stack[0] = _states_map[state_name]
	_current_state = _states_stack[0]
	_current_state._enter()
