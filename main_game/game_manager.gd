class_name GameManager
extends Node

## Export variables
@export var menu_layer: CanvasLayer

## General variables
var previous_menu: Control = null

## Onready variables
# Menus
@onready var in_menu: bool = is_instance_valid(menu_layer)
@onready var menus: Array = menu_layer.get_children()
@onready var main_menu: MainMenu = $MenuLayer/MainMenu
@onready var settings: Settings = $MenuLayer/Settings
@onready var pause_menu: PauseMenu = $MenuLayer/PauseMenu

# Animation player
@onready var endings: AnimationPlayer = $Endings

# Main scene
@onready var main: Main = $Main
@onready var timer_label: Label = $MenuLayer/TimerLabel


## Built-in functions 
func _ready() -> void:
	# Pause the game on startup because it loads into the main menu
	AudioManager.play_music("res://assets/audio/Scapegoats.mp3")
	get_tree().paused = true


func _input(event: InputEvent) -> void:
	# Pause the game
	if event.is_action_pressed("ui_cancel") and not in_menu:
		pause_menu.visible = true
		get_tree().paused = true


## Signals
# Play game
func _on_main_menu_play_game() -> void:
	exit_menus()
	main.visible = true
	timer_label.visible = true
func _on_pause_menu_resume_game() -> void:
	exit_menus()
	timer_label.visible = true


# Open settings
func _on_main_menu_switch_to_settings() -> void:
	main_menu.visible = false
	settings.visible = true
	previous_menu = main_menu
func _on_pause_menu_switch_to_settings() -> void:
	pause_menu.visible = false
	settings.visible = true
	previous_menu = pause_menu


func _on_settings_exit_settings() -> void:
	settings.visible = false
	previous_menu.visible = true


func _on_pause_menu_switch_to_main_menu() -> void:
	pause_menu.visible = false
	main.visible = false
	timer_label.visible = false
	in_menu = true
	get_tree().paused = true
	main_menu.visible = true


func _on_main_good_ending() -> void:
	endings.play("good_ending")


func _on_main_bad_ending() -> void:
	endings.play("bad_ending")


func _on_main_true_good_ending() -> void:
	endings.play("true_good_ending")


## General use functions
func exit_menus() -> void:
	for menu in menus:
		menu.visible = false
	in_menu = false
	get_tree().paused = false
