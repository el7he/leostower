extends Node2D
class_name teleporteur

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@export var autreteleporteur : teleporteur 
var isactivated : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if autreteleporteur is teleporteur : 
		autreteleporteur.autreteleporteur = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if isactivated == false : 
		if body is Player:
			
			audio_stream_player.play()
			autreteleporteur.isactivated=true
			#Gamemanager.playervar.position=Vector2(0,0)
			if autreteleporteur is teleporteur:
				Gamemanager.playervar.global_position=autreteleporteur.global_position
		pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		if isactivated == true : 
			isactivated = false
		
	pass # Replace with function body.
