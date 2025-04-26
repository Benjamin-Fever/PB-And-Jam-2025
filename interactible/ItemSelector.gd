extends Area2D

var selected_item : ItemRegion = null

func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	global_position = mouse_pos

	if selected_item:
		selected_item.global_position = mouse_pos
		if selected_item is VoltageRegion:
			selected_item.global_rotation_degrees = 0
			var angle = mouse_pos.angle_to_point(selected_item.lever_pivot.global_position)
			selected_item.lever_pivot.global_rotation = angle


func _input(event):
	if event.is_action_pressed("mouse_click") and get_overlapping_areas().size() > 0:
		var item = get_overlapping_areas()[0]
		if item is ItemRegion and selected_item == null:
			selected_item = item
			StateManager.current_item = item.item_state
		elif item is Interaction and selected_item == null:
			item.interact_with()

	elif event.is_action_released("mouse_click") and selected_item and !StateManager.is_in_action:
		if selected_item is VoltageRegion:
			var mouse_pos = get_global_mouse_position()
			var angle = mouse_pos.angle_to_point(selected_item.lever_pivot.global_position)
			selected_item.lever_pivot.global_rotation = angle
			selected_item.global_rotation = angle
		selected_item = null
		StateManager.current_item = StateManager.ItemState.NONE
