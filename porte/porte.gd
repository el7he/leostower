extends Node2D
@export var scenetoload : String = "res://scenefelicien2.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player : 
		SaveManager.save_game({"checkpoint":0})
		get_tree().change_scene_to_file(scenetoload)
		pass # Replace with function body.
