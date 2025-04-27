class_name ElectricHat
extends ItemRegion


var locked_in := false

@onready var npc: NPC = $"../NPC"


func _ready() -> void:
	super()
	process_priority = 10


func _process(delta: float) -> void:
	if locked_in:
		position = Vector2(948, home_position.y + 60)
		return
	
	super(delta)
	if global_position.distance_to(home_position) >= 70.0:
		global_position = home_position.direction_to(global_position) * 70.0 + home_position
	
	if not is_instance_valid(npc):
		npc = $"..".npc
	if position.y > home_position.y + 60 and not npc.has_bottom_fur and not npc.has_top_fur and not npc.has_left_horn and not npc.has_right_horn:
		locked_in = true
		CheckList.mark_done("helmet")
