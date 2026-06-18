extends Node2D

@export var scroll_speed: float = 60.0 # Vitesse du chenillard en pixels par seconde

@onready var trigger: Area2D = $Trigger
@onready var collision_shape: CollisionShape2D = $Trigger/CollisionShape2D
@onready var line_2d: Line2D = $Line2D

func _ready() -> void:
	if not collision_shape or not collision_shape.shape:
		return
		
	setup_dashed_shader()
	draw_collision_outline()
	
	trigger.body_entered.connect(_on_body_entered)

func setup_dashed_shader() -> void:
	# On vire la génération d'image CPU devenue inutile
	line_2d.texture = null 

	var shader := Shader.new()
	shader.code = """
		shader_type canvas_item;
		uniform float speed = 60.0;
		
		void fragment() {
			// On utilise les vrais pixels de l'écran pour une régularité parfaite
			// 16.0 correspond à la taille du motif (8px visible, 8px vide)
			float pixel_pos = FRAGCOORD.x + FRAGCOORD.y - (TIME * speed);
			
			if (mod(pixel_pos, 64.0) > 32.0) {
				discard; // Crée le trou des pointillés de manière nette
			}
			
			COLOR = COLOR; // Garde la couleur de la ligne définie dans l'éditeur
		}
	"""
	
	var mat := ShaderMaterial.new()
	mat.shader = shader
	mat.set_shader_parameter("speed", scroll_speed)
	line_2d.material = mat

func draw_collision_outline() -> void:
	line_2d.clear_points()
	line_2d.position = collision_shape.position
	line_2d.rotation = 0.0
	
	var shape = collision_shape.shape
	if shape is RectangleShape2D:
		var real_size = shape.size * collision_shape.scale
		var extents = real_size / 2.0
		
		var points = PackedVector2Array([
			Vector2(-extents.x, -extents.y),
			Vector2(extents.x, -extents.y),
			Vector2(extents.x, extents.y),
			Vector2(-extents.x, extents.y),
			Vector2(-extents.x, -extents.y)
		])
		line_2d.points = points

func _process(_delta: float) -> void:
	for body in trigger.get_overlapping_bodies():
		if body is Player and body.isdashing:
			body.die()

func _on_body_entered(body: Node2D) -> void:
	if body is Player and body.isdashing:
		body.die()
