extends CanvasLayer

@onready var horns : Control = $Control/Horns
@onready var fur : Control = $Control/Fur
@onready var wet : Control = $Control/Wet
@onready var helmet : Control = $Control/Helmet
@onready var voltage : Control = $Control/Voltage

func _ready():
	visible = false

func _process(delta):
	visible = true

func init_state(npc : NPC):
	fur.visible = npc.has_bottom_fur or npc.has_top_fur
	horns.visible = npc.left_horn or npc.right_horn
	(horns.get_node("CheckBox") as CheckBox).button_pressed = false
	(fur.get_node("CheckBox") as CheckBox).button_pressed = false
	(wet.get_node("CheckBox") as CheckBox).button_pressed = false
	(helmet.get_node("CheckBox") as CheckBox).button_pressed = false
	(voltage.get_node("CheckBox") as CheckBox).button_pressed = false
	
	
func mark_done(action : String, state: bool = true) -> void:
	if action == "horns":
		(horns.get_node("CheckBox") as CheckBox).button_pressed = state
	if action == "fur":
		(fur.get_node("CheckBox") as CheckBox).button_pressed = state
	if action == "wet":
		(wet.get_node("CheckBox") as CheckBox).button_pressed = state
	if action == "helmet":
		(helmet.get_node("CheckBox") as CheckBox).button_pressed = state
	if action == "voltage":
		(voltage.get_node("CheckBox") as CheckBox).button_pressed = state
