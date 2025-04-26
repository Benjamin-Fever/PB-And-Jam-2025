
extends Node

enum ItemState { NONE, SAW, SPONGE, SHAVER, VOLTAGE }
var current_item: StateManager.ItemState = StateManager.ItemState.NONE
var is_in_action : bool = false