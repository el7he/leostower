extends Control

func _ready() -> void:
	# optionnel : désactive le bouton "continuer" si aucune save n'existe
	$MarginContainer/VBoxContainer/Continue.disabled = not SaveManager.has_save()

func _on_new_game_pressed() -> void:
	SaveManager.reset_save()
	var err : Error = get_tree().change_scene_to_file(SaveManager.FIRST_LEVEL_PATH)
	print("résultat change_scene_to_file: ", err)

func _on_continue_pressed() -> void:
	var save_data : Dictionary = SaveManager.load_game()
	var level_path : String = save_data.get("level", SaveManager.FIRST_LEVEL_PATH)
	get_tree().change_scene_to_file(level_path)

func _on_options_pressed() -> void:
	pass

func _on_credits_pressed() -> void:
	pass
