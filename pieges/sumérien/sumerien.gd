extends CharacterBody2D
class_name  sumerienpiege

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var speed: float = 60.0
@export var follow_distance: float = 10.0  # Distance avant de commencer à suivre
@export var stop_distance: float = 5.0     # Distance d'arrêt
var player_node: Node2D = null 
var canfollow : bool = false;
@onready var sumerien: AudioStreamPlayer2D = $sumerien
@onready var sumerienfall: AudioStreamPlayer2D = $sumerienfall
@onready var sumerienslide: AudioStreamPlayer2D = $sumerienslide
var was_on_floor: bool = false
var sumerien_type: int = 0
'''
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

'''
func set_sumerien_type(sumerien2 : int) -> void :
	#print("sumerien : ",sumerien2)
	sumerien_type=sumerien2
	begin_sumerien()
	pass
func begin_sumerien() -> void:
	if player_node == null:
		player_node = Gamemanager.playervar
		canfollow = false
		
		sumerien.play()
		sumerien.finished.connect(_on_sumerien_finished)
		sumerien.play()
		if sumerien_type==1:
			await get_tree().create_timer(3.0).timeout
			canfollow = true
			sumerienslide.play()
			sumerienslide.finished.connect(_on_sumerienslide_finished)
			sumerienslide.play()

func _on_sumerien_finished():
	sumerien.play()  # Rejoue l'audio

func _on_sumerienslide_finished():
	sumerienslide.play()  # Rejoue l'audio
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if is_on_floor() and not was_on_floor:
		onlanding()
	
	was_on_floor = is_on_floor()
	
	if not is_on_floor():
		velocity += get_gravity() * delta * 5.4
	if canfollow :
		var direction_x = player_node.global_position.x - global_position.x
		if abs(direction_x) > follow_distance:
			var movement = sign(direction_x) * speed * delta * 1000
			velocity.x = movement
		else :
			velocity.x = 0
		
	move_and_slide()
		
func onlanding() ->void : 
	sumerienfall.play()
	pass
	'''
	# Calculer la différence sur l'axe X seulement
	
	# Ne suivre que si le joueur est trop loin
	if abs(direction_x) > follow_distance:
		# Normaliser le mouvement
		var movement = sign(direction_x) * speed * delta
		velocity.x = movement
	else:
		# S'arrêter si assez proche
		velocity.x = 0
	
	move_and_slide()
	'''
