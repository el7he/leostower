extends lifecharacter
class_name enemy
@export var speed = 100.0
@export var gravity : float = 0.0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var player_node: Node2D = null
#var havegravity : bool = false
@export var follow_distance = 50.0
#@export var projectile_list: Array[String]
#@export var objet_a_spawner: Array[PackedScene] = []
#q@onready var spawner: Sprite2D = $spawner
@onready var wet_splat_2d: AudioStreamPlayer2D = $WetSplat2D
var was_on_floor: bool = false
var arene : arena
var detectedplayer : bool = false

func _ready() -> void:
	super()
	if player_node == null:
		player_node = Gamemanager.playervar
	#projectilecadence()
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * gravity
	
	if is_on_floor() and not was_on_floor:
		onlanding()
	
	was_on_floor = is_on_floor()
	
	pass

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#move_toward_player()
	
	
	
	
	
	
	'''
	var direction := 1#Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	'''	
	move_and_slide()
	
	
	
	
	
	
	
	
	
	
	

	
func onlanding() ->void:
	pass
	
func take_damage(damage: float) -> void:
	super(damage)
	wet_splat_2d.play()
	
	

func move_toward_player() -> void :
	if detectedplayer==true : 
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
		pass
	
	
func die() -> void:
	super()
	#print("ahh")
	if arene is arena : 
		arene.open()
		pass
	queue_free()
	
	
func set_life(new_life: float) -> void:
	super(new_life)
	
	#print("zer : ",life)
	
func projectilecadence()->void:
	spawnprojectile(0)
	await get_tree().create_timer(1.30).timeout
	projectilecadence()
	
	
func spawnprojectile(angle : float,  projectileclass : String = 'res://life/projectiles/projectilepar.tscn',shotspeed : float = 300) ->void: 
	var path : String = projectileclass
	if ResourceLoader.exists(path):
		var scene: PackedScene = load(path)
		var nouvelle_instance = scene.instantiate()
		nouvelle_instance.global_position = global_position
		nouvelle_instance.rotation = deg_to_rad(angle)
		get_tree().current_scene.add_child(nouvelle_instance)
		nouvelle_instance.begin_projectile(self,shotspeed)
	#nouvelle_instance.beginforward(rotation)
	


func _on_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		detectedplayer = true
	pass # Replace with function body.
