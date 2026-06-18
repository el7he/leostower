extends Control
@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var labeloption: Label = $Labeloption
@onready var labelcredit: Label = $Labelcredit


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
	if labeloption.visible==false :
		labeloption.visible=true
		await get_tree().create_timer(2.0).timeout
		labeloption.visible=false
	pass

func _on_credits_pressed() -> void:
	DisplayServer.clipboard_set(rich_text_label.text)
	if labelcredit.visible==false:
		labelcredit.visible=true
		await get_tree().create_timer(2.0).timeout
		labelcredit.visible=false
	pass
	
func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
