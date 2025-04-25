class_name Settings
extends Control


signal exit_settings()


func _on_exit_pressed() -> void:
	exit_settings.emit()
