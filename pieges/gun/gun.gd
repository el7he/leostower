extends Node2D
class_name gun
@export var objet_a_spawner: PackedScene
@onready var spawner: Sprite2D = $spawner

var isactivated : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func aim_at_player_angle() -> float :
	var player_node = Gamemanager.playervar
	var direction = player_node.global_position - global_position
	var angle_rad = atan2(direction.y, direction.x)
	var angle_deg = rad_to_deg(angle_rad)
	return angle_deg


func beginforward(rotation2):
	rotation = rotation2
	print("rotation : ",rotation2)
	if isactivated == false :
			isactivated=true
			var nouvelle_instance = objet_a_spawner.instantiate()
			nouvelle_instance.global_position = spawner.global_position
			get_tree().current_scene.add_child(nouvelle_instance)
			nouvelle_instance.global_position = spawner.global_position
			nouvelle_instance.global_rotation = global_rotation
			if nouvelle_instance is camion : 
				print("gun : ",nouvelle_instance)
				nouvelle_instance.beginforward(rotation)
				
	pass
