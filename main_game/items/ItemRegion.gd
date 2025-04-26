class_name ItemRegion
extends Area2D



@export var item_state : ItemState.States = ItemState.States.NONE
var home_position : Vector2 = Vector2.ZERO

func _ready():
	home_position = global_position

func _process(_delta):
	global_position = global_position.lerp(home_position, 0.1)
