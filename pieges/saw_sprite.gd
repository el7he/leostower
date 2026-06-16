extends Sprite2D

@export var spin_speed = 3

func _physics_process(delta):
	rotate(delta*spin_speed)
