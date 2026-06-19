extends Area2D

@export var spawn_height: float = 700.0
@export var fall_speed: float = 850.0
@export var max_fall_distance: float = 2500.0

@onready var stone = $stone
@onready var meteorite_hitbox = $stone/trigger 

var is_falling: bool = false
var start_y_position: float = 0.0

func _ready() -> void:
	stone.freeze = true
	stone.visible = false
	stone.position.y = -spawn_height
	
	body_entered.connect(_on_player_triggered)
	print("Piège unique ", name, " prêt dans le niveau.")

func _process(delta: float) -> void:
	if is_falling:
		stone.position.y += fall_speed * delta
		if stone.position.y > start_y_position + max_fall_distance:
			print("Météorite unique ", name, " supprimée proprement ! 🧹")
			queue_free()

func _on_player_triggered(body: Node2D) -> void:
	print(name, " touché par : ", body.name)
	if body is Player:
		print("Joueur détecté sur ", name, " ! Lancement de la chute.")
		body_entered.disconnect(_on_player_triggered)
		
		start_y_position = stone.position.y
		stone.visible = true
		is_falling = true
		
		meteorite_hitbox.body_entered.connect(_on_meteorite_hit_player)

func _on_meteorite_hit_player(body: Node2D) -> void:
	if body is Player:
		print("BOOM ! Le joueur s'est fait écraser par ", name)
		body.die()
