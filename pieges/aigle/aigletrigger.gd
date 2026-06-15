extends Node2D
@export var objet_a_spawner: PackedScene
@onready var spawner: Sprite2D = $spawner


var isactivated : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func beginforward () ->void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if isactivated == false :
			isactivated=true
			var nouvelle_instance = objet_a_spawner.instantiate()
			nouvelle_instance.global_position = spawner.global_position
			get_tree().current_scene.add_child(nouvelle_instance)
 			#nouvelle_instance.beginforward(rotation)
			pass 
