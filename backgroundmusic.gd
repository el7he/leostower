extends Node2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready():
	# Chercher automatiquement le joueur si non assigné
	audio_stream_player.play()
	audio_stream_player.finished.connect(_on_audio_stream_player_finished)
	audio_stream_player.play()

func _on_audio_stream_player_finished():
	audio_stream_player.play()  # Rejoue l'audio

func adjust_volume(audiodir : int = 1):
	pass
	var bus_index = AudioServer.get_bus_index("Master")
	var current_volume = AudioServer.get_bus_volume_db(bus_index)
	var new_volume = current_volume + (10 * audiodir)
	new_volume = clamp(new_volume, -80.0, 10.0)  # -80dB = muet, 10dB = max
	AudioServer.set_bus_volume_db(bus_index, new_volume)
	'''
	# Récupérer le bus maître (ou un bus spécifique)
	var bus_index = AudioServer.get_bus_index("Master")
	var current_volume = AudioServer.get_bus_volume_db(bus_index)
	
	# Calculer le nouveau volume
	var new_volume = current_volume + (volume_step if is_increase else -volume_step)
	
	# Limiter le volume (optionnel)
	new_volume = clamp(new_volume, -80.0, 10.0)  # -80dB = muet, 10dB = max
	
	# Appliquer le nouveau volume
	AudioServer.set_bus_volume_db(bus_index, new_volume)
	
	# Émettre un signal pour mettre à jour un affichage si nécessaire
	volume_changed.emit(new_volume)
	'''
