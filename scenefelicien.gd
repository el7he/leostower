extends Node2D

#@onready var cursor: Sprite2D = $CursorLayer/cursor

@onready var inputmapping: Control = $GUI/Inputmapping



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#cursor.global_position = get_global_mouse_position()
	pass
'''
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		gamepaused = !gamepaused
		if gamepaused:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Engine.time_scale = 0
			inputmapping.visible=true
		else : 
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			Engine.time_scale = 1
			inputmapping.visible=false
		get_tree().root.get_viewport().set_input_as_handled()
	pass
'''
