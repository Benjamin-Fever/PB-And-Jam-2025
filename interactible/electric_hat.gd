class_name ElectricHat
extends ItemRegion


func _ready() -> void:
	super()
	process_priority = 10


func _process(delta: float) -> void:
	super(delta)
	if global_position.distance_to(home_position) >= 30.0:
		global_position = home_position.direction_to(global_position) * 30.0 + home_position
