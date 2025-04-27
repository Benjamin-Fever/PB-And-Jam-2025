
extends Node

enum ItemState { NONE, SAW, SPONGE, SHAVER, VOLTAGE }
var current_item: StateManager.ItemState :
	get:
		return _state
	set(value):
		_state = value
		match value:
			ItemState.NONE:
				AudioManager.play_sound("")
			ItemState.SHAVER:
				AudioManager.play_sound("res://assets/audio/shaver-held-loop.mp3")
			ItemState.SAW:
				AudioManager.play_sound("res://assets/audio/pickup-saw.mp3")
			ItemState.SPONGE:
				AudioManager.play_sound("res://assets/audio/sponge-pickup.mp3")


var _state : StateManager.ItemState

var is_in_action : bool = false
