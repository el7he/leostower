extends enemy
#@export var doudoutest : Array[float] = []
@onready var onlandingsfx: AudioStreamPlayer2D = $Onlanding
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
@onready var sprite_2d_3: Sprite2D = $Sprite2D3
@onready var abeille: AudioStreamPlayer2D = $abeille
@onready var mitraillette: AudioStreamPlayer2D = $mitraillette
@onready var moto: AudioStreamPlayer2D = $moto



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	#print("objet a spawn : ",objet_a_spawner.size())
	#sprite_2d_2.visible=false
	#sprite_2d.visible=true
	showsprite(0)
	
	
	#global_position = Vector2(player_node.global_position.x, global_position.y)
	#havegravity = true;
	pass # Replace with function body.
	#teleportloop()
	
	abeille.play()
	abeille.finished.connect(_on_abeille_finished)
	abeille.play()

func _on_abeille_finished():
	abeille.play()  # Rejoue l'audio

func spawnprojectilesalve(projectileclass : String= 'res://life/projectiles/projectilegoutte.tscn', shotspeed : float = 500) ->void:
	spawnprojectile(aim_at_player_angle(),projectileclass,shotspeed)
	#, cadence : float = 0.3, projectilenumber:int = 6
	
func onsalve(salveindex : int =0) ->void:
	super(salveindex)
	#showsprite(0)
	match salveindex:
		0:
			#spawnprojectilesalve()
			spawnprojectile_circle(5,(advancement*20),"res://life/projectiles/projectileabeille.tscn",550,1)
			pass
		1:
			spawnprojectilesalve('res://life/projectiles/projectileballe.tscn',750)
			pass
		2:
			abeilletp()
			pass
			#spawnprojectilesalve('res://life/projectiles/projectilevague.tscn',300) #2,2
		_:
			print("Autre valeur")  # Cas par défaut


func abeilletp() -> void:
	global_position = Vector2(teleportpoints[2].x-200,teleportpoints[2].y+300)
	velocity = Vector2(900, 0)
	
	pass
	

	
func salvebegin(salveindex : int =0)->void:
	super(salveindex)
	print("doudou : ",salveindex)
	showsprite(0)
	
	match salveindex:
		0:
			#gravity = 0
			pass
		1:
			mitraillette.play()
			showsprite(1)
			#spawnprojectilesalve()
			pass
		2:
			moto.play()
			setdamagevalue(5)
			showsprite(2)
			pass
			#spawnprojectilesalve('res://life/projectiles/projectilevague.tscn',300,2,2)
		_:
			pass
			#print("Autre valeur")  # Cas par défaut
	
func onendsalve(salveindex : int ) -> void:
	super(salveindex)
	setdamagevalue(1)
	moto.stop()
	mitraillette.stop()
	showsprite(0)
	match salveindex:
		0:
			#gravity = 0
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
	#onlandingsfx.play()
	#print("SOL")
	
func showsprite(spriteindex : int = 0) -> void : 
	#return
	pass
	sprite_2d_2.visible=false
	sprite_2d.visible=false
	sprite_2d_3.visible=false
	match spriteindex:
		0:
			sprite_2d.visible=true
			#pieton.play()
		1:
			sprite_2d_2.visible=true
			
			pass
		
		2:
			sprite_2d_3.visible=true
			pass
	pass






'''
extends enemy
@onready var abeille: AudioStreamPlayer2D = $abeille
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
#@export var doudoutest : Array[float] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	abeille.play()
	abeille.finished.connect(_on_abeille_finished)
	abeille.play()

func _on_abeille_finished():
	abeille.play()  # Rejoue l'audio

func spawnprojectilesalve(projectileclass : String, shotspeed : float, damage : int) ->void:
	spawnprojectile(aim_at_player_angle(),projectileclass,shotspeed, damage)
	#, cadence : float = 0.3, projectilenumber:int = 6

func salvebegin(salveindex : int =0)->void:
	super(salveindex)
	pass
	
	showsprite(0)
	match salveindex:
		0:
			pass
			#pieton.play()
		1:
			showsprite(1)
			pass
		
		2:
			pass
func showsprite(spriteindex : int = 0) -> void : 
	return
	pass
	sprite_2d_2.visible=false
	sprite_2d.visible=false
	match spriteindex:
		0:
			sprite_2d.visible=true
			#pieton.play()
		1:
			sprite_2d_2.visible=true
			
			pass
		
		2:
			pass
	pass
func onsalve(salveindex : int =0) ->void:
	super(salveindex)
	match salveindex:
		0:
			#abeilletp()
			pass
		1:
			
			#abeilletp()
			#spawnprojectile_circle(8,0,'res://life/projectiles/projectilepanneau.tscn',1000,1)
			#spawnprojectilesalve('res://life/projectiles/projectilecamion.tscn',300,5) #2,2
			pass
		2:
			#abeilletp()
			pass
		_:
			print("Autre valeur")  # Cas par défaut

func abeilletp() -> void:
	global_position = Vector2(teleportpoints[2].x, player_node.global_position.y)
	velocity = Vector2(400, 0)
	
	pass
	
func onendsalve(salveindex : int ) -> void:
	#showsprite(0)
	super(salveindex)
	match salveindex:
		0:
			#gravity = 0
			pass
		1:
			#spawnprojectilesalve()
			showsprite(0)
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
	pass

func onlanding() ->void:
	super()
	
'''
