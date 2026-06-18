extends Node2D

@export var rotation_speed: float = 1.5

@onready var trigger: Area2D = $Trigger
@onready var collision_shape: CollisionShape2D = $Trigger/CollisionShape2D
@onready var line_2d: Line2D = $Line2D

func _ready() -> void:
	if not collision_shape or not collision_shape.shape:
		return
		
	# On génère informatiquement la texture en pointillés pour le Line2D
	setup_dashed_texture()
	draw_collision_outline()
	
	trigger.body_entered.connect(_on_body_entered)
	trigger.body_exited.connect(_on_body_exited)

func setup_dashed_texture() -> void:
	# Crée une image de 16x1 pixels : moitié blanche, moitié transparente
	var image := Image.create(16, 1, false, Image.FORMAT_RGBA8)
	for x in range(16):
		if x < 8:
			image.set_pixel(x, 0, Color.WHITE)
		else:
			image.set_pixel(x, 0, Color.TRANSPARENT)
			
	# On applique cette image comme texture répétée sur la ligne
	var texture := ImageTexture.create_from_image(image)
	line_2d.texture = texture
	line_2d.texture_mode = Line2D.LINE_TEXTURE_TILE

func draw_collision_outline() -> void:
	line_2d.clear_points()
	var shape = collision_shape.shape
	line_2d.position = collision_shape.position
	
	if shape is RectangleShape2D:
		var extents = shape.size / 2.0
		line_2d.add_point(Vector2(-extents.x, -extents.y))
		line_2d.add_point(Vector2(extents.x, -extents.y))
		line_2d.add_point(Vector2(extents.x, extents.y))
		line_2d.add_point(Vector2(-extents.x, extents.y))
		line_2d.closed = true
		
	elif shape is CircleShape2D:
		var radius = shape.radius
		var points_count = 32
		for i in range(points_count):
			var angle = i * (PI * 2.0) / points_count
			var point = Vector2(cos(angle), sin(angle)) * radius
			line_2d.add_point(point)
		line_2d.closed = true

func _process(delta: float) -> void:
	line_2d.rotation += rotation_speed * delta

	for body in trigger.get_overlapping_bodies():
		if body is Player and body.isdashing:
			body.die()

func _on_body_entered(body: Node2D) -> void:
	if body is Player and body.isdashing:
		body.die()

func _on_body_exited(_body: Node2D) -> void:
	pass
