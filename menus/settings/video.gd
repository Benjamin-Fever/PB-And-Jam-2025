class_name SettingsVideo
extends ScrollContainer


@export var resolutions: Array[Vector2i] = [Vector2i(854, 480), Vector2i(1280, 720), Vector2i(1920, 1080), Vector2i(2560, 1440), Vector2i(3840, 2160)]


@onready var settings_that_dont_work_when_embedded: Array = [
	$VBoxContainer/Resolution/ResolutionOption, 
	$VBoxContainer/WindowMode, 
	$VBoxContainer/HSeparator1, 
	$VBoxContainer/Resolution, 
	$VBoxContainer/HSeparator2
]

@onready var resolution_option: OptionButton = $VBoxContainer/Resolution/ResolutionOption
@onready var window_mode_option: OptionButton = $VBoxContainer/WindowMode/WindowModeOption


func _ready() -> void:
	if get_window().is_embedded() || Engine.is_embedded_in_editor():
		for setting in settings_that_dont_work_when_embedded:
			setting.visible = false
	else:
		resolution_option.clear()
		for i in range(resolutions.size()):
			var label = str(resolutions[i].x) + "x" + str(resolutions[i].y)
			resolution_option.add_item(label, i)
			if get_window().size == resolutions[i]:
				resolution_option.select(i)
		
		window_mode_option.select(get_window().mode)


func _on_resolution_option_item_selected(index: int) -> void:
	DisplayServer.window_set_size(resolutions[index])


func _on_fullscreen_option_item_selected(index: int) -> void:
	DisplayServer.window_set_mode(index)


func _on_option_button_item_selected(index: int) -> void:
	DisplayServer.window_set_vsync_mode(index)


func start_reset_countdown() -> void:
	pass # TODO: implement resetting settings
