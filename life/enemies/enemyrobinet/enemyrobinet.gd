extends enemy
#@export var doudoutest : Array[float] = []
@onready var onlandingsfx: AudioStreamPlayer2D = $Onlanding

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	#print("objet a spawn : ",objet_a_spawner.size())
	print("robinet lifemax : ",lifemax, " life : ",life)
	
	
	#global_position = Vector2(player_node.global_position.x, global_position.y)
	#havegravity = true;
	pass # Replace with function body.
	#teleportloop()

func spawnprojectilesalve(projectileclass : String= 'res://life/projectiles/projectilegoutte.tscn', shotspeed : float = 500) ->void:
	spawnprojectile(aim_at_player_angle(),projectileclass,shotspeed)
	#, cadence : float = 0.3, projectilenumber:int = 6
	
func onsalve(salveindex : int =0) ->void:
	super(salveindex)
	match salveindex:
		0:
			robinettp()
			pass
		1:
			spawnprojectilesalve()
			pass
		2:
			pass
			spawnprojectilesalve('res://life/projectiles/projectilevague.tscn',300) #2,2
		_:
			print("Autre valeur")  # Cas par défaut

func robinettp() -> void:
	velocity = Vector2(0, 0)
	gravity = 6
	global_position = Vector2(player_node.global_position.x, player_node.global_position.y-300)
	
	#advancement+=1
	
	#await get_tree().create_timer(1.0).timeout
	'''
	if advancement==3:
		chooseteleportpoint()
	else :
		robinettp()
	'''
	pass
	
func onendsalve(salveindex : int ) -> void:
	super(salveindex)
	match salveindex:
		0:
			gravity = 0
			pass
		1:
			#spawnprojectilesalve()
			pass
		2:
			pass
			#spawnprojectilesalve('res://life/projectiles/projectilevague.tscn',300,2,2)
		_:
			pass
			#print("Autre valeur")  # Cas par défaut
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	#move_toward_player()
	#global_position = Vector2(player_node.global_position.x, global_position.y)
	#global_position = Vector2(global_position.x,global_position.y+1)
	pass

func onlanding() ->void:
	super()
	onlandingsfx.play()
	#print("SOL")
	






'''
extends enemy
var teleportpoints : Array[Vector2] = []
#@export var doudoutest : Array[float] = []
var advancement : int = 0;
@onready var onlandingsfx: AudioStreamPlayer2D = $Onlanding

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	#print("objet a spawn : ",objet_a_spawner.size())
	print("robinet lifemax : ",lifemax, " life : ",life)
	teleportpoints.append(global_position);
	teleportpoints.append(Vector2(global_position.x+150,global_position.y));
	teleportpoints.append(Vector2(global_position.x-150,global_position.y));
	chooseteleportpointloop()
	
	#global_position = Vector2(player_node.global_position.x, global_position.y)
	#havegravity = true;
	pass # Replace with function body.
	#teleportloop()

func chooseteleportpointloop() -> void:
	chooseteleportpoint()
	#await get_tree().create_timer(1.30).timeout
	#chooseteleportpointloop()

func chooseteleportpoint() -> void :
	velocity = Vector2(0, 0)
	advancement = 0
	var random_index = randi_range(0, teleportpoints.size() - 1)
	global_position = teleportpoints[random_index]
	#spawnprojectilesalve()
	
	
	await get_tree().create_timer(1).timeout
	
	match random_index:
		0:
			robinettp()
		1:
			spawnprojectilesalve()
		2:
			spawnprojectilesalve('res://life/projectiles/projectilevague.tscn',300,2,2)
		_:
			print("Autre valeur")  # Cas par défaut
	
	
	pass

func spawnprojectilesalve(projectileclass : String= 'res://life/projectiles/projectilegoutte.tscn', shotspeed : float = 500, cadence : float = 0.3, projectilenumber:int = 6) ->void:
	var direction = player_node.global_position - global_position
	var angle_rad = atan2(direction.y, direction.x)
	var angle_deg = rad_to_deg(angle_rad)
	
	spawnprojectile(angle_deg,projectileclass,shotspeed)
	advancement+=1
	await get_tree().create_timer(cadence).timeout
	if advancement==projectilenumber:
		chooseteleportpoint()
	else :
		spawnprojectilesalve(projectileclass,shotspeed,cadence,projectilenumber)
	pass

func robinettp() -> void:
	await get_tree().create_timer(1.0).timeout
	velocity = Vector2(0, 0)
	gravity = 6
	global_position = Vector2(player_node.global_position.x, player_node.global_position.y-300)
	
	advancement+=1
	
	await get_tree().create_timer(1.0).timeout
	if advancement==3:
		gravity = 0
		chooseteleportpoint()
	else :
		robinettp()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	#move_toward_player()
	#global_position = Vector2(player_node.global_position.x, global_position.y)
	#global_position = Vector2(global_position.x,global_position.y+1)
	pass

func onlanding() ->void:
	super()
	onlandingsfx.play()
	#print("SOL")
	

'''
