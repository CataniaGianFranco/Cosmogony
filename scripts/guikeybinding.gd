extends CanvasLayer

var file_name = "res://keymap.json"

var key_dict = {"ui_jump": 32,
				"ui_right": 37,
				"ui_left": 39}

var _setting_key: bool = false
var _is_pause: bool = false
 
func _ready() -> void:
	load_keys()
	get_child(0).visible = false
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

#We'll use this when the game loads
func load_keys() -> void:
	var file = File.new()
	if file.file_exists(file_name):
		delete_old_keys()
		file.open(file_name,File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if(typeof(data) == TYPE_DICTIONARY):
			key_dict = data
			setup_keys()
		else:
			print("Corrupted data!")
	else:
		#NoFile, so lets save the default keys now
		save_keys()

func delete_old_keys() -> void:
	#Remove the old keys
	for i in key_dict:
		var oldkey = InputEventKey.new()
		oldkey.scancode = int(Guikeybinding.key_dict[i])
		InputMap.action_erase_event(i,oldkey)

func setup_keys() -> void:
	for i in key_dict:
		for j in get_tree().get_nodes_in_group("button_keys"):
			if(j.action_name == i):
				j.text = OS.get_scancode_string(key_dict[i])
		var newkey = InputEventKey.new()
		newkey.scancode = int(key_dict[i])
		InputMap.action_add_event(i,newkey)
	
func save_keys() -> void:
	var file = File.new()
	file.open(file_name,File.WRITE)
	file.store_string(to_json(key_dict))
	file.close()
	print("Saved")

func _on_Quit_pressed() -> void:
	get_tree().quit()


func _on_Main_menu_pressed() -> void:
	get_child(0).visible = false
	get_tree().paused = false
	get_tree().call_deferred("change_scene", "res://scenes/MainMenu.tscn")
