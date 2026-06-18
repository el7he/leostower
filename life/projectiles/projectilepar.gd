extends CharacterBody2D

var speed = 300.0
@onready var damagecube: damage_cube = $Damagecube
#var exception : lifecharacter;
@onready var audio_on_start: AudioStreamPlayer2D = $"Audio on start"
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var fixsprite : bool = false
@export var audioloop : bool = false


func _physics_process(delta):
	# Obtenir la direction vers l'avant (direction locale "right" du personnage)
	var direction = Vector2.RIGHT.rotated(rotation)
	if fixsprite == true : 
		sprite_2d.global_rotation = deg_to_rad(0)
	
	# Appliquer le mouvement
	velocity = direction * speed
	move_and_slide()

func _audioloop():
	print("loop")
	audio_on_start.play()
	audio_on_start.finished.connect(_on_audio_on_start_finished)
	audio_on_start.play()

func _on_audio_on_start_finished():
	audio_on_start.play()  # Rejoue l'audio


func begin_projectile(exception2 : lifecharacter, speed2 : float,damage : int = 1)  -> void : 
	#print("cube : ",damagecube)
	if exception2!=null:
		if damagecube!=null:
			damagecube.exception = exception2
			damagecube.setdisabled(false)
			damagecube.damage_value = damage
			speed = speed2
			if audioloop==false:
				audio_on_start.play()
			else :
				_audioloop()
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
