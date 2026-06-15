extends Node2D
class_name damage_cube
@export var damage_value : float = 1
@export var exception : lifecharacter;
@export var disabled : bool = false;
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
var connector : damage_connector 
@export var iscontinue : bool = true



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setdisabled(disabled)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
	
func setdisabled(disabled2 : bool) -> void : 
	disabled=disabled2;
	collision_shape_2d.disabled = disabled2;

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is lifecharacter:
		if body != exception:
			body.take_damage(damage_value);
			if body.life>0 && iscontinue:
				delayonhit()
			
			if connector is damage_connector:
				connector.onhit()
			
		#print("goy")
	pass # Replace with function body.

func delayonhit() -> void : 
	var delay : float = 0.3
	await get_tree().create_timer(delay).timeout
	setdisabled(true)
	await get_tree().create_timer(delay).timeout
	setdisabled(false)
	
	
	
func eneffet() ->void:
	print("oulah")
