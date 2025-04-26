extends Area2D

@export var cut_distance : int = 200
@export var cut_durability : int = 3

@export_group("Refrences")
@export var saw_sprite : Node2D
@export var saw_line : Node2D


var saw_item : ItemRegion

func _ready():
	area_entered.connect(_on_area_entered)
	saw_sprite.visible = false
	saw_line.visible = false

func _process(_delta):
	saw_line.visible = StateManager.current_item == StateManager.ItemState.SAW


func _on_area_entered(area):
	if (area is ItemRegion and (area as ItemRegion).item_state == StateManager.ItemState.SAW):
		if (StateManager.is_in_action):
			return
		saw_sprite.visible = true
		cut_durability = 3
		saw_item = area as ItemRegion
		saw_item.visible = false
		StateManager.is_in_action = true





# func _process(_delta):
#     var mouse_pos = get_global_mouse_position()
#     if (Input.is_action_just_pressed("mouse_click")):
#         start_position = mouse_pos
#     if (Input.is_action_pressed("mouse_click")):
#         var distance = start_position.distance_to(mouse_pos)
#         if (distance > cut_distance):
#             start_position = mouse_pos
#             cut_durability -= 1
#             if (cut_durability <= 0):
#                 queue_free()
