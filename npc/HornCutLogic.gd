extends Area2D

signal saw_complete

@export var cut_distance : int = 1000
@export var cut_durability : int = 3

@export_group("Refrences")
@export var saw_sprite : Node2D
@export var saw_line : Node2D

@onready var horn: Sprite2D = $Horn


var item : ItemRegion

var start_cut_position : Vector2 = Vector2.ZERO
var initial_saw_position : Vector2 = Vector2.ZERO

func _ready():
	area_entered.connect(_on_area_entered)
	saw_sprite.visible = false
	saw_line.visible = false
	initial_saw_position = saw_sprite.global_position
	if name == "LHorn":
		horn.frame = randi_range(6, 11)
	else:
		horn.frame = randi_range(12, 17)


func _process(_delta):
	initial_saw_position = saw_sprite.global_position
	
	saw_line.visible = StateManager.current_item == StateManager.ItemState.SAW
	var mouse_pos = get_global_mouse_position()

	if Input.is_action_just_pressed("mouse_click") and saw_sprite.visible:
		start_cut_position = mouse_pos


	if Input.is_action_pressed("mouse_click") and saw_sprite.visible and start_cut_position != Vector2.ZERO:
		match StateManager.current_item:
			StateManager.ItemState.SAW:
				pass


		var dist = start_cut_position.distance_to(mouse_pos)
		saw_sprite.global_position = saw_sprite.global_position.lerp(initial_saw_position + (mouse_pos - initial_saw_position).normalized() * dist, 0.1)
		if dist > cut_distance:
			cut_durability -= 1
			if cut_durability <= 0:
				cut_durability = 3
				StateManager.is_in_action = false
				item.global_position = mouse_pos
				item.visible = true
				emit_signal("saw_complete")
				queue_free()


func _on_area_entered(area):
	if (area is ItemRegion and (area as ItemRegion).item_state == StateManager.ItemState.SAW):
		if (StateManager.is_in_action):
			return
		var mouse_pos = get_global_mouse_position()
		saw_sprite.visible = true
		cut_durability = 3
		item = area as ItemRegion
		item.visible = false
		StateManager.is_in_action = true
		start_cut_position = mouse_pos
