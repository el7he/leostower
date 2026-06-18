extends Control
@onready var input_button_scene = preload("res://ui/inputbutton.tscn")
@onready var actionlist = $PanelContainer2/Actionlist
@onready var buttonexit: Button = $PanelContainer3/Button


var is_remapping = false
var action_to_remap = null
var remapping_button = null
var input_actions = {
	"move_left":"move_left",
	"move_right":"move_right",
	"jump":"jump",
	"dash":"dash",
	"sword":"sword",
	"up":"up",
	"down":"down"
}

func _ready() -> void:
	# [NOUVEAU] On part des inputs du projet, puis on écrase avec ceux sauvegardés.
	# L'ordre est important : load_from_project_settings() d'abord,
	# sinon load_inputs() n'aurait rien sur quoi s'appuyer.
	InputMap.load_from_project_settings()
	SaveManager.load_inputs(input_actions)  # adapte "SaveManager" au nom de ton autoload
	_create_action_list()
	buttonexit.pressed.connect(_on_buttonexit_pressed)

func _on_buttonexit_pressed():
	#print("Bouton cliqué !")
	Gamemanager.playervar.hidepause(false)
	# Votre code ici
	
func _create_action_list() -> void:
	# [MODIFIÉ] Le load_from_project_settings() a été retiré d'ici
	# et déplacé dans _ready(), car on ne veut pas réinitialiser les inputs
	# à chaque reconstruction de la liste (ex. après un remapping).
	for item in actionlist.get_children():
		item.queue_free()
	
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		var display_event = _get_first_keyboard_mouse_event(events)
		if display_event:
			input_label.text = display_event.as_text().trim_suffix(" - Physical")
		else:
			input_label.text = ""
			
		actionlist.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))
	
func _get_first_keyboard_mouse_event(events: Array) -> InputEvent:
	for event in events:
		if event is InputEventKey or event is InputEventMouseButton:
			return event
	return null

func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Press key to bind..."
		
func _input(event: InputEvent) -> void:
	if is_remapping:
		if (
			event is InputEventKey || 
			(event is InputEventMouseButton && event.pressed)
		):
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			_remove_keyboard_mouse_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			# [NOUVEAU] Sauvegarde immédiatement après chaque remapping,
			# pour ne pas perdre les changements si le jeu est quitté sans passer
			# par un écran de sauvegarde explicite.
			SaveManager.save_inputs(input_actions)  # adapte "SaveManager" au nom de ton autoload
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()

func _remove_keyboard_mouse_events(action: String) -> void:
	var events = InputMap.action_get_events(action)
	for event in events:
		if event is InputEventKey or event is InputEventMouseButton:
			InputMap.action_erase_event(action, event)

func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" - Physical")
