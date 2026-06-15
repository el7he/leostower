extends CharacterBody2D

@export var speed := 3000.0

func beginforward(rotation2):
	rotation = rotation2
	pass

func _physics_process(delta):
	# Calculer la direction vers l'avant (basé sur la rotation)
	var forward_direction = Vector2.RIGHT.rotated(rotation)
	#print("rotation : ",rotation)
	
	# Déplacer l'objet
	velocity = forward_direction * speed
	move_and_slide()
