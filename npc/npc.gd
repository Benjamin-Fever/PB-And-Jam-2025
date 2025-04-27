class_name NPC
extends Node2D


signal burned_up()

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
@export var is_wet : bool = false
@export var current_body_type: BodyType = BodyType.SMALL


@export_group("Refrences")
@export var top_fur: Node2D
@export var bottom_fur: Node2D
@export var face_sprite: Sprite2D
@export var left_horn: Node2D
@export var right_horn: Node2D
@export var head: Node2D
@export var body: Sprite2D
@export var BaseColor: Sprite2D
@export var Face: Sprite2D

@onready var burn_animation: AnimationPlayer = $BurnAnimation
@onready var face: Sprite2D = $Head/Face
@onready var base_color: Sprite2D = $Head/BaseColor

var current_npc : bool = true
var is_current_npc : bool :
	get:
		return current_npc
	set(value):
		current_npc = value
		if value:
			CheckList.init_state(self)


func _ready():
	_update()
	



func _update():
	if not has_bottom_fur:
		bottom_fur.queue_free()
	if not has_top_fur:
		top_fur.queue_free()
	if not has_left_horn:
		left_horn.queue_free()
	if not has_right_horn:
		right_horn.queue_free()
	face_sprite.modulate = face_color
	head.position = BODY_TYPE_OFFSETS[current_body_type]
	body.frame = current_body_type + 1


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


func _on_burn_animation_animation_finished(_anim_name: StringName) -> void:
	burned_up.emit()


func update_shave_pos() -> void:
	if top_fur:
		top_fur.initial_saw_position = top_fur.global_position
	if bottom_fur:
		bottom_fur.initial_saw_position = bottom_fur.global_position
	if left_horn:
		left_horn.initial_saw_position = left_horn.global_position
	if right_horn:
		right_horn.initial_saw_position = right_horn.global_position
