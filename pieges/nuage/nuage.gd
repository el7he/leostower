extends Node2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
var isactivated : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if isactivated == false:
		if body is Player:
			isactivated=true
			var value = randf_range(0.7, 1.5)
			audio_stream_player_2d.pitch_scale=value
			audio_stream_player_2d.play()
			await get_tree().create_timer(1.5).timeout
			queue_free()
		pass # Replace with function body.
