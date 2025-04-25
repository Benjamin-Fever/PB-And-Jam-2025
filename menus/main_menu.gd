class_name MainMenu
extends Control


signal play_game()
signal switch_to_settings()


func _on_play_pressed() -> void:
	play_game.emit()


func _on_settings_pressed() -> void:
	switch_to_settings.emit()
