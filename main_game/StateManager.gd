
extends Node

enum ItemState { NONE, SAW, SPONGE, SHAVER, VOLTAGE }
@export var current_item: StateManager.ItemState = StateManager.ItemState.NONE