extends Area2D

@export var cut_distance : int = 200
@export var cut_durability : int = 3



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
