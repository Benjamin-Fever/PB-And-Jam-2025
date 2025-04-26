class_name ItemState
extends Node2D

enum States { NONE, SAW, SPONGE, SHAVER, VOLTAGE }
@export var current_item: ItemState.States = ItemState.States.NONE

func _change_state(new_state: ItemState.States):
	current_item = new_state
	match current_item:
		ItemState.States.SAW:
			print("Saw selected")
		ItemState.States.SPONGE:
			print("Sponge selected")
		ItemState.States.SHAVER:
			print("Shaver selected")
		ItemState.States.VOLTAGE:
			print("Voltage selected")
		_:
			print("No item selected")
