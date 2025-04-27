class_name File
extends TextureRect


@onready var name_label: Label = $Name
@onready var offense_label: Label = $Offense
@onready var size_label: Label = $Size

var mouse_inside = false
var is_following = false
var movement_offset = Vector2.ZERO
var home_position


func _ready() -> void:
	home_position = global_position


func _on_mouse_entered() -> void:
	mouse_inside = true


func _on_mouse_exited() -> void:
	mouse_inside = false


func _input(event: InputEvent) -> void:
	if mouse_inside and Input.is_action_just_pressed("mouse_click"):
		is_following = true
		movement_offset = global_position - get_global_mouse_position()
	elif Input.is_action_just_released("mouse_click"):
		is_following = false
	if is_following and event is InputEventMouseMotion:
		global_position = get_global_mouse_position() + movement_offset


func _process(delta: float) -> void:
	if not is_following:
		global_position = lerp(global_position, home_position, 0.1)
