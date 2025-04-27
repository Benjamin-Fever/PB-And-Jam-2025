
extends Node

enum ItemState { NONE, SAW, SPONGE, SHAVER, VOLTAGE }
var current_item: StateManager.ItemState :
    get:
        return _state
    set(value):
        _state = value
        match value:
            ItemState.NONE:
                AudioManager.stream = null
            ItemState.SHAVER:
                AudioManager.stream = ResourceLoader.load("res://assets/audio/shaver-held-loop.mp3")
        AudioManager.play()


var _state : StateManager.ItemState

var is_in_action : bool = false
