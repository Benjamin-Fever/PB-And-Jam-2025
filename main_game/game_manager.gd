class_name GameManager
extends Node


@export var menu_layer: CanvasLayer

@onready var in_menu: bool = is_instance_valid(menu_layer)
@onready var menus: Array = menu_layer.get_children()
@onready var main_menu: MainMenu = $MenuLayer/MainMenu
@onready var settings: Settings = $MenuLayer/Settings

@onready var main: Main = $Main


func _ready() -> void:
	get_tree().paused = true


func _on_main_menu_play_game() -> void:
	exit_menus()
	main.visible = true


func open_main_menu() -> void:
	main.visible = false
	in_menu = true
	get_tree().paused = true
	main_menu.visible = true


func _on_main_menu_switch_to_settings() -> void:
	main_menu.visible = false
	settings.visible = true


func exit_menus() -> void:
	for menu in menus:
		menu.visible = false
	in_menu = false
	get_tree().paused = true
