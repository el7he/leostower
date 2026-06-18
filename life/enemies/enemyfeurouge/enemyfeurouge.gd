extends enemy
#@export var doudoutest : Array[float] = []
@onready var onlandingsfx: AudioStreamPlayer2D = $Onlanding
@onready var pieton: AudioStreamPlayer2D = $pieton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	#print("objet a spawn : ",objet_a_spawner.size())
	print("robinet lifemax : ",lifemax, " life : ",life)
	
	
	#global_position = Vector2(player_node.global_position.x, global_position.y)
	#havegravity = true;
	pass # Replace with function body.
	#teleportloop()

func spawnprojectilesalve(projectileclass : String, shotspeed : float, damage : int) ->void:
	spawnprojectile(aim_at_player_angle(),projectileclass,shotspeed, damage)
	#, cadence : float = 0.3, projectilenumber:int = 6

func salvebegin(salveindex : int =0)->void:
	pass
	match salveindex:
		0:
			pieton.play()
	
func onsalve(salveindex : int =0) ->void:
	super(salveindex)
	match salveindex:
		0:
			#robinettp()
			
			spawnprojectile_circle(8,aim_at_player_angle(),'res://life/projectiles/projectilepanneau.tscn',400,1)
			#spawnprojectilesalve('res://life/projectiles/projectilepanneau.tscn',400,1)
			pass
		1:
			global_position = Vector2(player_node.global_position.x-15000, player_node.global_position.y)
			spawnprojectile(0,'res://life/projectiles/projectiletgv.tscn',6500,5)
			#spawnprojectile_circle(8,0,'res://life/projectiles/projectilepanneau.tscn',1000,1)
			#spawnprojectilesalve('res://life/projectiles/projectilecamion.tscn',300,5) #2,2
			pass
		2:
			pass
			spawnprojectilesalve('res://life/projectiles/projectilecamion.tscn',700,5) #2,2
		_:
			print("Autre valeur")  # Cas par défaut

func feurougetp() -> void:
	velocity = Vector2(0, 0)
	#gravity = 6
	
	
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
	#ddonlandingsfx.play()
	#print("SOL")
	
