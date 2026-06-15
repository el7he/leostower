extends CharacterBody2D

var speed = 300.0
@onready var damagecube: damage_cube = $Damagecube
#var exception : lifecharacter;
@onready var audio_on_start: AudioStreamPlayer2D = $"Audio on start"


func _physics_process(delta):
	# Obtenir la direction vers l'avant (direction locale "right" du personnage)
	var direction = Vector2.RIGHT.rotated(rotation)
	
	# Appliquer le mouvement
	velocity = direction * speed
	move_and_slide()

func begin_projectile(exception2 : lifecharacter, speed2 : float) -> void : 
	#print("cube : ",damagecube)
	if exception2!=null:
		if damagecube!=null:
			damagecube.exception = exception2
			damagecube.setdisabled(false)
			speed = speed2
			audio_on_start.play()
			await get_tree().create_timer(5.0).timeout
			queue_free()
			#print("oui : ")
		#exception = exception2
		#print("oui",exception2)
		
		#damagecube.eneffet()
		
	#if exception2!=null:
	#	damagecube.exception = exception2
	#damagecube.disabled=false
	pass
