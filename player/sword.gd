extends damage_connector
class_name sword
@onready var damagecube: damage_cube = $Sword/Damagecube
@export var exception : Player;

func onhit() -> void:
	super()
	if rotation_degrees==0:
		if exception is Player:
			
			exception.pogo()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	damagecube.exception = exception
	damagecube.connector = self
	pass # Replace with function body.



func setdisabled(disabled2 : bool) ->void:
	damagecube.setdisabled(disabled2);
	#print("d ")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	pass
