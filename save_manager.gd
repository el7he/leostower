extends Node
const save_file_name : String = "user://save.json"
const default_dictionary : Dictionary = {"checkpoint":0}

func save_game(data: Dictionary) ->void:
	var save_file : FileAccess = FileAccess.open(save_file_name, FileAccess.WRITE)
	if save_file==null:
		push_error("Error opening file")
		return
	var string_data : String = JSON.stringify(data)
	save_file.store_line(string_data)
	save_file.close()

func load_game() -> Dictionary:
	if FileAccess.file_exists(save_file_name):
		var save_file: FileAccess = FileAccess.open(save_file_name,FileAccess.READ)
		if save_file==null:
			push_error("Error reading file")
			return default_dictionary
		var json = JSON.new()
		var string_data : String = save_file.get_line()
		if json.parse(string_data) == OK:
			var data : Dictionary = json.get_data()
			save_file.close()
			return data
		push_error("corrupted data")
	return default_dictionary

func reset_save() -> void:
	save_game(default_dictionary)

# [NOUVEAU] Sauvegarde les remappings clavier/souris dans le fichier de save.
# On récupère d'abord la save existante pour ne pas écraser les autres données
# (checkpoint, etc.), puis on y injecte la clé "input_map".
func save_inputs(input_actions: Dictionary) -> void:
	var save_data : Dictionary = load_game()

	var input_map_data : Dictionary = {}
	for action in input_actions:
		var events = InputMap.action_get_events(action)
		var serialized_events : Array = []
		for event in events:
			# On ne sauvegarde que clavier et souris (ignore les manettes)
			if event is InputEventKey:
				serialized_events.append({
					"type": "key",
					"keycode": event.keycode,
					"physical_keycode": event.physical_keycode,
					"shift": event.shift_pressed,
					"ctrl": event.ctrl_pressed,
					"alt": event.alt_pressed
				})
			elif event is InputEventMouseButton:
				serialized_events.append({
					"type": "mouse",
					"button_index": event.button_index
				})
		input_map_data[action] = serialized_events

	save_data["input_map"] = input_map_data
	save_game(save_data)

# [NOUVEAU] Charge et applique les remappings depuis la save.
# Retourne true si des inputs sauvegardés ont été trouvés et appliqués.
func load_inputs(input_actions: Dictionary) -> bool:
	var save_data : Dictionary = load_game()

	# Pas de clé "input_map" dans la save → rien à restaurer
	if not save_data.has("input_map"):
		return false

	var input_map_data : Dictionary = save_data["input_map"]

	for action in input_actions:
		if not input_map_data.has(action):
			continue

		# Supprime uniquement les événements clavier/souris actuels de cette action
		var current_events = InputMap.action_get_events(action)
		for event in current_events:
			if event is InputEventKey or event is InputEventMouseButton:
				InputMap.action_erase_event(action, event)

		# Reconstruit et réapplique chaque événement sérialisé
		for event_data in input_map_data[action]:
			if event_data["type"] == "key":
				var event = InputEventKey.new()
				event.keycode = event_data["keycode"]
				event.physical_keycode = event_data["physical_keycode"]
				event.shift_pressed = event_data["shift"]
				event.ctrl_pressed = event_data["ctrl"]
				event.alt_pressed = event_data["alt"]
				InputMap.action_add_event(action, event)
			elif event_data["type"] == "mouse":
				var event = InputEventMouseButton.new()
				event.button_index = event_data["button_index"]
				InputMap.action_add_event(action, event)

	return true
