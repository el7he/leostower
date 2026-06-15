extends Node2D

@export_category("Configuration")
@export var key_scene: PackedScene 
# Le nombre total de clés sera : GRID_COLS * GRID_ROWS
@export var grid_columns: int = 3
@export var grid_rows: int = 2

@export_category("Paramètres du Mélange")
@export var shuffle_count: int = 15
@export var shuffle_speed: float = 0.3 # Temps en secondes par échange

@export_category("Espacement Visuel")
@export var spacing_x: float = 60.0       
@export var spacing_y: float = 60.0        
@export var line_spacing: float = 80.0 
@export var start_offset_y: float = -150.0 

@onready var trigger_collision: CollisionShape2D = $Trigger/CollisionShape2D
@onready var caillou: Node2D = $Caillou

var keys_list: Array[Node2D] = []
var is_shuffling: bool = false

func _on_trigger_body_entered(body: Node2D) -> void:
	if is_shuffling:
		return
		
	if body is Player:
		is_shuffling = true
		trigger_collision.set_deferred("disabled", true)
		call_deferred("start_shuffle_sequence")

func start_shuffle_sequence() -> void:
	spawn_keys_grid()
	
	if keys_list.is_empty():
		is_shuffling = false
		return

	# Choisir la bonne clé au hasard et la montrer brièvement
	var random_index = randi() % keys_list.size()
	await keys_list[random_index].set_right()
	
	await shuffle_keys_sequence(shuffle_count)
	await align_keys_in_line()
	
	for key in keys_list:
		key.can_interact = true

func spawn_keys_grid() -> void:
	keys_list.clear()
	
	var start_x = -((grid_columns - 1) * spacing_x) / 2.0
	var start_y = start_offset_y - ((grid_rows - 1) * spacing_y) / 2.0
	
	for row in range(grid_rows):
		for col in range(grid_columns):
			var key_instance = key_scene.instantiate() as Node2D
			add_child(key_instance)
			
			key_instance.position = Vector2(start_x + (col * spacing_x), start_y + (row * spacing_y))
			
			key_instance.scale = Vector2.ZERO
			var tween = create_tween()
			tween.tween_property(key_instance, "scale", Vector2(0.4, 0.4), 0.2)
			
			keys_list.append(key_instance)

func shuffle_keys_sequence(times: int) -> void:
	var total_keys = keys_list.size()
	# Nombre de paires max qu'on peut mélanger en même temps
	var pairs_count = total_keys / 2 
	
	for i in range(times):
		# Générer la liste des index disponibles
		var indices = []
		for n in range(total_keys):
			indices.append(n)
		indices.shuffle()
		
		var tween = create_tween().set_parallel(true)
		
		for pair in range(pairs_count):
			var idx_a = indices[pair * 2]
			var idx_b = indices[pair * 2 + 1]
			
			var key_a = keys_list[idx_a]
			var key_b = keys_list[idx_b]
			
			# Utilise la variable shuffle_speed exportée
			tween.tween_property(key_a, "position", key_b.position, shuffle_speed).set_trans(Tween.TRANS_SINE)
			tween.tween_property(key_b, "position", key_a.position, shuffle_speed).set_trans(Tween.TRANS_SINE)
			
			keys_list[idx_a] = key_b
			keys_list[idx_b] = key_a
			
		await tween.finished

func align_keys_in_line() -> void:
	var start_x = -((keys_list.size() - 1) * line_spacing) / 2.0
	
	var tween = create_tween().set_parallel(true)
	
	for i in range(keys_list.size()):
		var target_pos = Vector2(start_x + (i * line_spacing), start_offset_y)
		tween.tween_property(keys_list[i], "position", target_pos, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		
	await tween.finished

func open_door() -> void:
	if caillou:
		caillou.queue_free()
	
	for key in keys_list:
		if is_instance_valid(key):
			key.queue_free()
