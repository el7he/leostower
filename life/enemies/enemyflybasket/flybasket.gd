extends enemy

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	super()
	audio_stream_player_2d.play()
	audio_stream_player_2d.finished.connect(onsoundfinished)
	audio_stream_player_2d.play()
	
	

func cadencemouche() -> void : 
	spawnprojectile(aim_at_player_angle(),"res://life/projectiles/projectilebasket.tscn",500,1)
	await get_tree().create_timer(1.30).timeout
	cadencemouche()
	pass
	
func onplayerdetected() -> void:
	cadencemouche()
	
func onsoundfinished() ->void:
	audio_stream_player_2d.play()
	pass
'''
	eagle.play()
	eagle.finished.connect(_on_eagle_finished)
	eagle.play()

func _on_eagle_finished():
	eagle.play()  # Rejoue l'audio
'''
func _process(delta: float) -> void:
	super(delta)
	move_toward_player()
