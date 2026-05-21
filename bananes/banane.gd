extends Node2D
@onready var singemange: AudioStreamPlayer2D = $singemange
@onready var sprite_2d: Sprite2D = $Sprite2D
var iseaten : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if iseaten==false : 
			iseaten=true
			sprite_2d.visible=false
			body.eat()
			singemange.play()
		#queue_free()
	pass # Replace with function body.
