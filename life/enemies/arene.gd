extends Node2D
class_name arena

@export var porte1 : arenedoor
@export var porte2 : arenedoor
@export var enemyarena : enemy
var baseenemyspawn : Vector2
var currentstep : int = 0
var enemypath : String = ''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	baseenemyspawn = enemyarena.global_position
	
	var chemin_fichier = enemyarena.scene_file_path
	#res://life/enemies/enemyrobinet/enemyrobinet.tscn
	enemypath = enemyarena.scene_file_path
	print('chemin : ')
	print(chemin_fichier)
	enemyarena.queue_free()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnboss() -> void :
	
	var path : String = enemypath
	if ResourceLoader.exists(path):
		var scene: PackedScene = load(path)
		var nouvelle_instance = scene.instantiate()
		nouvelle_instance.global_position = baseenemyspawn
		#nouvelle_instance.rotation = deg_to_rad(angle)
		get_tree().current_scene.add_child(nouvelle_instance)
		nouvelle_instance.arene = self
		#nouvelle_instance.begin_projectile(self,shotspeed)
	pass
func open() -> void : 
	porte1.open()
	porte2.open()
	currentstep = 2
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	
		if body is Player :
			if currentstep==0:
				currentstep = 1
				if porte1 is arenedoor && porte2 is arenedoor : 
					porte1.close()
					porte2.close()
					spawnboss()
