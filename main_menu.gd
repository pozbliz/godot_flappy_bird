extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/StartGameButton.pressed.connect(_on_start_game_button_pressed)
	$VBoxContainer/OptionsButton.pressed.connect(_on_options_button_pressed)
	$VBoxContainer/ExitGameButton.pressed.connect(_on_exit_game_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_game_button_pressed():
	hide()
	get_tree().change_scene_to_file("res://main.tscn")
	
func _on_options_button_pressed():
	pass
	
func _on_exit_game_button_pressed():
	get_tree().quit()
