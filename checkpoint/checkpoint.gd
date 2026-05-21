extends Node2D
class_name checkpoint
@export var index : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dict : Dictionary =SaveManager.load_game()
	
	var checkpointint:int = 0;
	checkpointint = dict["checkpoint"];
	print("checkpoint : ",checkpointint)
	if checkpointint==index:
		Gamemanager.playervar.teleport(global_position.x,global_position.y)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		SaveManager.save_game({"checkpoint":index})
		#print("checkpoint ! ")
