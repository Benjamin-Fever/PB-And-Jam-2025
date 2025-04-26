extends Node2D

@export var face_color : Color = Color(1, 1, 1)
@export var has_left_horn: bool = true
@export var has_right_horn: bool = true
@export var has_top_fur: bool = true
@export var has_bottom_fur: bool = true


@export_group("Refrences")
@export var top_fur : Node2D
@export var bottom_fur : Node2D
@export var face_sprite : Sprite2D
@export var left_horn : Node2D
@export var right_horn : Node2D


func _ready():
	_update();


func _update():
	face_sprite.modulate = face_color
	top_fur.visible = has_top_fur
	bottom_fur.visible = has_bottom_fur
	left_horn.visible = has_left_horn
	right_horn.visible = has_right_horn

func _remove_top_fur():
	has_top_fur = false

func _remove_bottom_fur():
	has_bottom_fur = false

func _remove_left_horn():
	has_left_horn = false

func _remove_right_horn():
	has_right_horn = false
