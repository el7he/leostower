extends Area2D

@export var launch_force : int = -850

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	print("Orbe Tremplin ", name, " parée au décollage !")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("CONTACT ! ", name, " propulse instantanément le joueur !")
		
		if body.has_method("pogo"):
			body._execute_jump(launch_force)
		else:
			body.velocity.y = launch_force
