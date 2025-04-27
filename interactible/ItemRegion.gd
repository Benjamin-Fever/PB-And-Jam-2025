class_name ItemRegion
extends Area2D


@export var held_sound : AudioStream
@export var item_state : StateManager.ItemState = StateManager.ItemState.NONE
var home_position : Vector2 = Vector2.ZERO

func _ready():
	home_position = global_position

func _process(_delta):
	global_position = global_position.lerp(home_position, 0.1)
