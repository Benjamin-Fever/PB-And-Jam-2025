class_name ElectricHat
extends ItemRegion


func _process(delta: float) -> void:
	super(delta)
	if global_position.distance_to(home_position) >= 30.0:
		global_position = home_position.direction_to(global_position) * 30.0 + home_position
