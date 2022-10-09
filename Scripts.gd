extends Button

export(String) var action_name = ""

var _do_set: bool = false

func _pressed():
	text = ""
	_do_set = true
	
func _input(event) -> void:
	if(_do_set):
		if(event is InputEventKey):
			#Remove the old keys
			var newkey: InputEventKey = InputEventKey.new()
			newkey.scancode = int(Guikeybinding.key_dict[action_name])
			InputMap.action_erase_event(action_name,newkey)
			#Add the new key for this action
			InputMap.action_add_event(action_name,event)
			#Show it as readable to the user
			text = OS.get_scancode_string(event.scancode)
			#Update the keydictionary with the scanscode to save
			Guikeybinding.key_dict[action_name] = event.scancode
			#Save the dictionary to json
			Guikeybinding.save_keys()
			#stop setting the key
			_do_set = false
			
