extends Area2D

signal shave_complete

@export var cut_distance : int = 1000

@export_group("Refrences")
@export var shave_sprite : Node2D
@export var shave_line : Node2D

var item : ItemRegion

var start_cut_position : Vector2 = Vector2.ZERO
var initial_saw_position : Vector2 = Vector2.ZERO

func _ready():
	area_entered.connect(_on_area_entered)
	shave_sprite.visible = false
	shave_line.visible = false
	initial_saw_position = shave_sprite.global_position

func _process(_delta):
	shave_line.visible = StateManager.current_item == StateManager.ItemState.SHAVER
	var mouse_pos = get_global_mouse_position()

	if Input.is_action_just_pressed("mouse_click") and shave_sprite.visible:
		start_cut_position = mouse_pos


	if Input.is_action_pressed("mouse_click") and shave_sprite.visible and start_cut_position != Vector2.ZERO:
		var dist = start_cut_position.distance_to(mouse_pos)
		shave_sprite.global_position = shave_sprite.global_position.lerp(initial_saw_position + (mouse_pos - initial_saw_position).normalized() * dist, 0.1)
		shave_sprite.global_position.y = initial_saw_position.y
		if dist > cut_distance:
			StateManager.is_in_action = false
			item.global_position = mouse_pos
			item.visible = true
			emit_signal("shave_complete")
			queue_free()


func _on_area_entered(area):
	if (area is ItemRegion and (area as ItemRegion).item_state == StateManager.ItemState.SHAVER):
		if (StateManager.is_in_action):
			return
		var mouse_pos = get_global_mouse_position()
		shave_sprite.visible = true
		item = area as ItemRegion
		item.visible = false
		StateManager.is_in_action = true
		start_cut_position = mouse_pos
