extends Node2D
class_name playersprite
var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.
	

func beginloop() -> void : 
	tween = create_tween().set_loops()  # set_loops() sans argument = infini
	
	# Anime la rotation de 0 à TAU (360 degrés en radians) sur 2 secondes
	# La méthode .from(0) est cruciale pour que chaque boucle recommence à 
	tween.tween_property(self, "rotation", TAU, 0.30).from(0)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func endloop() -> void : 
	tween.kill()
	rotation=0
	

func _process(delta: float) -> void:
	pass
