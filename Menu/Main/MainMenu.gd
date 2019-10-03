extends Control

func _input(event):
	 if event is InputEventKey and event.scancode == KEY_SPACE:
        play_game()

func _on_PlayButton_pressed():
	GLOBAL.init_game()

func _on_ExitButton_pressed():
	get_tree().quit()

func play_game():
	GLOBAL.init_game()
	