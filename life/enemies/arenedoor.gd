extends Node2D
class_name arenedoor
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D3/CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setenabled(false)
	#setenabled(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func setenabled(enabled:bool) ->void:
	pass
	collision_shape_2d.set_deferred("disabled", !enabled)
	sprite_2d.visible=enabled

func open() ->void:
	setenabled(false)
	
func close() -> void:
	setenabled(true)
	#sprite_2d.visible=false
	#setenabled(true)
	
	
	pass
