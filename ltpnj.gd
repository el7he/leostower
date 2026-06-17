extends Node2D

@onready var hitbox: Area2D = $Hitbox
@onready var hitbox_collision: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var hitbox_sprite: Sprite2D = $Hitbox/Sprite2D
@onready var thunder_player: AudioStreamPlayer2D = $SoundPlayer
@onready var monologue_player: AudioStreamPlayer2D = $Monologue

@export var monologue_time = 45
@export var play_anim = true


# Variable pour gérer le cooldown (downtime)
var is_active: bool = false

func _ready() -> void:
	hitbox_sprite.hide()
	hitbox_collision.disabled = true

func _on_trigger_body_entered(body: Node2D) -> void:
	# Si l'éclair est déjà activé ou en cooldown, on ne fait rien
	if is_active:
		return
		
	if body is Player:
		is_active = true # On bloque le piège immédiatement
		
		body.is_stunned = true
		if play_anim:
			$AnimationPlayer.play("idle")
		monologue_player.play()
		await get_tree().create_timer(monologue_time).timeout
		
		# 2. Éclair & Son
		hitbox_sprite.show()
		thunder_player.play()
		
		await get_tree().create_timer(0.1).timeout
		hitbox_collision.disabled = false
		
		await get_tree().create_timer(0.85).timeout
		
		# 3. Nettoyage de l'attaque
		hitbox_sprite.hide()
		hitbox_collision.disabled = true
		
		# 4. Downtime (cooldown) de 5 secondes
		await get_tree().create_timer(5.0).timeout
		is_active = false # Le piège peut de nouveau être déclenché

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
