class_name SettingsVideo
extends ScrollContainer


@export var resolutions: Array[Vector2i] = [Vector2i(854, 480), Vector2i(1280, 720), Vector2i(1920, 1080), Vector2i(2560, 1440), Vector2i(3840, 2160)]

@onready var resolution_option: OptionButton = $VBoxContainer/Resolution/ResolutionOption
@onready var window_mode: Setting = $VBoxContainer/WindowMode
@onready var h_separator1: HSeparator = $VBoxContainer/HSeparator1
@onready var resolution: Setting = $VBoxContainer/Resolution
@onready var h_separator_2: HSeparator = $VBoxContainer/HSeparator2


func _ready() -> void:
	if get_window().is_embedded() || Engine.is_embedded_in_editor():
		window_mode.visible = false
		h_separator1.visible = false
		resolution.visible = false
		h_separator_2.visible = false
	
	resolution_option.clear()
	for i in range(resolutions.size()):
		var label = str(resolutions[i].x) + "x" + str(resolutions[i].y)
		resolution_option.add_item(label, i)
		if get_window().size == resolutions[i]:
			resolution_option.select(i)


func _on_resolution_option_item_selected(index: int) -> void:
	DisplayServer.window_set_size(resolutions[index])


func _on_fullscreen_option_item_selected(index: int) -> void:
	DisplayServer.window_set_mode(index)


func _on_option_button_item_selected(index: int) -> void:
	DisplayServer.window_set_vsync_mode(index)


func start_reset_countdown() -> void:
	pass # TODO: implement resetting settings
