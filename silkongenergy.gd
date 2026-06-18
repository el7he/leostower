extends Node2D

@onready var collision: CollisionShape2D = $Trigger/CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D # Adapte le nom selon ton arbre de scène

func _on_trigger_body_entered(body: Node2D) -> void:
	if body is Player and body.hasdashedinair:
		body.hasdashedinair = false
		
		# Désactive le cristal temporairement
		collision.set_deferred("disabled", true)
		$AudioStreamPlayer2D.play()
		sprite.hide()
		
		# Attend 3 secondes avant de le faire réapparaître
		await get_tree().create_timer(3.0).timeout
		
		sprite.show()
		collision.disabled = false
