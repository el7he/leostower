extends CharacterBody2D

@export var speed = 600.0
@export var follow_distance = 50.0  # Distance à laquelle le cube s'arrête
@export var player_node: Node2D = null  # Référence au joueur
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var eagle: AudioStreamPlayer2D = $eagle

var basescalex : float# = 1

func _ready():
	# Chercher automatiquement le joueur si non assigné
	if player_node == null:
		player_node = Gamemanager.playervar
	basescalex = sprite_2d.scale.x
	eagle.play()
	eagle.finished.connect(_on_eagle_finished)
	eagle.play()
	await get_tree().create_timer(2.0).timeout
	queue_free()

func _on_eagle_finished():
	eagle.play()  # Rejoue l'audio

func _physics_process(delta):
	
	# Flip selon la direction horizontale
	if velocity.x > 0:
		sprite_2d.scale.x = basescalex * -1
	else :
		sprite_2d.scale.x = basescalex * 1
	
	#sprite_2d.scale.x = sprite_2d.scale.x * lookingdir
		
	if player_node == null:
		return
	
	# Calculer la direction vers le joueur
	var direction = (player_node.global_position - global_position).normalized()
	var distance_to_player = global_position.distance_to(player_node.global_position)
	
	# Ne se déplacer que si on est trop loin
	if distance_to_player > follow_distance:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
