extends Node2D
@onready var audio_stream_player: AudioStreamPlayer = $Area2D/AudioStreamPlayer
var isactivated : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if isactivated == false : 
			isactivated=true
			
			audio_stream_player.play()
			pass
