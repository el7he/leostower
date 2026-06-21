extends Node2D

@export var isyes : bool
@onready var label: Label = $Label
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var rire: AudioStreamPlayer = $rire

var jumpforce : float
var speed : float
var playervar2 : Player
var delay : int = 120
var isplaying : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if isyes : 
		label.text="yes"
	else :
		label.text="no"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		playervar2 = body
		
		if isyes:
			var arraystats : Array[float] =  body.stopmovingquestionboss()
			
			speed = arraystats[0]
			jumpforce = arraystats[1]
			isplaying=true
			rires()
			delayloop()
		else :
			body.die()
			
func delayloop() ->void:
	label.text=str("You will skip the boss in ",delay," s")
	audio_stream_player.play()
	if delay==0:
		
		isplaying=false
		afterdelay()
	else :
		
		delay-=1
		await get_tree().create_timer(1.0).timeout
		delayloop()
	pass

func afterdelay() -> void:
	playervar2.max_speed = speed
	playervar2.jump_force = jumpforce
	playervar2.global_position = playervar2.gobackbossposition
	pass
	
func rires() ->void:
	var randomcri = randi_range(1, 4)
	var cri = "res://pieges/questionboss/Sitcom Laughter Sound Effect"+str(randomcri)+".wav"
	if isplaying:
		rire.stream = load(cri)
		rire.play()
		var randomduration = randi_range(11, 20)
		await get_tree().create_timer(randomduration).timeout
		rires()
		
	pass
