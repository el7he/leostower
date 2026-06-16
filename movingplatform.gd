extends Node2D

@export var speed: float = 150.0 # Vitesse en pixels par seconde

@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D
@onready var trigger_collision: CollisionShape2D = $Trigger/CollisionShape2D
@onready var audio_player = $AudioStreamPlayer2D

var is_moving: bool = false

func _process(delta: float) -> void:
	if is_moving:
		# progress augmente la position le long du chemin directement en pixels
		path_follow.progress += speed * delta
		
		# Optionnel : Si tu veux que la plateforme s'arrête pile à la fin du Path
		if path_follow.progress_ratio >= 1.0:
			is_moving = false
			audio_player.stop()

func _on_trigger_body_entered(body: Node2D) -> void:
	if body is Player and not is_moving:
		is_moving = true
		audio_player.play()
		trigger_collision.set_deferred("disabled", true) # Évite de relancer le trigger
