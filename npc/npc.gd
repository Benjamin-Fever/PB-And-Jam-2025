class_name NPC
extends Node2D


enum BodyType {
	SMALL,
	MEDIUM,
	LARGE
}

const BODY_TYPE_OFFSETS = [Vector2(0, 0), Vector2(0, -40), Vector2(0, -75)]

@export var face_color : Color = Color(1, 1, 1)
@export var has_left_horn: bool = true
@export var has_right_horn: bool = true
@export var has_top_fur: bool = true
@export var has_bottom_fur: bool = true
@export var current_body_type: BodyType = BodyType.SMALL


@export_group("Refrences")
@export var top_fur: Node2D
@export var bottom_fur: Node2D
@export var face_sprite: Sprite2D
@export var left_horn: Node2D
@export var right_horn: Node2D
@export var head: Node2D

@onready var burn_animation: AnimationPlayer = $BurnAnimation


func _ready():
	_update()


func _update():
	face_sprite.modulate = face_color
	top_fur.visible = has_top_fur
	bottom_fur.visible = has_bottom_fur
	left_horn.visible = has_left_horn
	right_horn.visible = has_right_horn
	head.position = BODY_TYPE_OFFSETS[current_body_type]

func _remove_top_fur():
	has_top_fur = false

func _remove_bottom_fur():
	has_bottom_fur = false

func _remove_left_horn():
	has_left_horn = false

func _remove_right_horn():
	has_right_horn = false


func _on_lever_start_electrocution() -> void:
	burn_animation.play("burn")
