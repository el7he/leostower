extends Node2D
class_name checkpoint

@export var index : int = 1
@onready var yay: AudioStreamPlayer2D = $yay

func _ready() -> void:
	if getcheckpointint() == index:
		Gamemanager.playervar.teleport(global_position.x, global_position.y)

func getcheckpointint() -> int:
	var dict : Dictionary = SaveManager.load_game()
	return dict.get("checkpoint", 0)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if getcheckpointint() != index:
			yay.play()
			var level_path : String = get_tree().current_scene.scene_file_path
			SaveManager.update_save({"checkpoint": index, "level": level_path})
