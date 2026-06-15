extends Node2D

@onready var right_key: bool = false
@export var right_texture: Texture2D
@export var normal_texture: Texture2D

var can_interact: bool = false
@onready var sprite: Sprite2D = $Sprite2D

func set_right() -> void:
	right_key = true
	# Affiche la bonne texture pendant 0.5s pour montrer au joueur laquelle suivre
	sprite.texture = right_texture
	await get_tree().create_timer(0.5).timeout
	sprite.texture = normal_texture

func _on_hitbox_body_entered(body: Node2D) -> void:
	if not can_interact:
		return

	if body is Player:
		if not right_key:
			body.die()
		else:
			# Appelle la fonction sur le script parent (Keys) pour détruire le caillou
			get_parent().open_door()
