extends enemy

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	super()
	audio_stream_player_2d.play()
	audio_stream_player_2d.finished.connect(onsoundfinished)
	audio_stream_player_2d.play()

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
