class_name PauseMenu
extends Control


signal resume_game()
signal switch_to_settings()


func _on_resume_pressed() -> void:
	resume_game.emit()


func _on_settings_pressed() -> void:
	switch_to_settings.emit()
