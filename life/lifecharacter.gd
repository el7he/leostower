extends CharacterBody2D
class_name lifecharacter
var life : float = 5;
@export var lifemax : float = 5;
var isalive : bool = true
var cannotdie : bool = false
#var hitowner : lifecharacter
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_life(lifemax)
	#print("mozart")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func set_life(new_life: float) -> void:
	if isalive==true:
		life = clamp(new_life, 0, lifemax)
		#print("life",life)
		if life==0:
			
			die()
	

func change_life(amount: float) -> void:
	set_life(life+amount)

func take_damage(damage: float,hitowner2) -> void:
	onhit(hitowner2)
	change_life(-damage)

func onhit(hitowner2) -> void :
	pass
	
func die() -> void:
	print("isalive :",isalive)
	if isalive:
		isalive=false
		if cannotdie == false:
			die2()
	pass
	#queue_free()
func die2() ->void:
	pass
