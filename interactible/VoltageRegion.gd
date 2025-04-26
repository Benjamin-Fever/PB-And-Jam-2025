class_name VoltageRegion
extends ItemRegion

@export var voltage_low_rotation : int = 0
@export var voltage_med_rotation : int = 0
@export var voltage_high_rotation : int = 0
@export var lever_pivot : Node2D

var voltage_level : int = 0

func _ready():
	home_position = global_position
	rotation_degrees = voltage_low_rotation
	lever_pivot.rotation_degrees = voltage_low_rotation
