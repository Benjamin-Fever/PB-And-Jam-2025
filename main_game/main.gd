class_name Main
extends Node2D


signal good_ending()
signal bad_ending()
signal true_good_ending()

const START_X_POS = 2300
const END_X_POS = 950

const NPC_SCENE = preload("res://npc/npc.tscn")
const CHAIR = preload("res://npc/chair.tscn")


@onready var npc: NPC = $NPC
@onready var chair: Sprite2D = $Chair
@onready var timer_label: Label = $"../MenuLayer/TimerLabel"
@onready var electric_hat: ElectricHat = $ElectricHat
@onready var pivot: Node2D = $Interactables/Voltage/Pivot
@onready var lever: VoltageRegion = $Interactables/Voltage/Lever
@onready var electro_lever: ElectrocutionLever = $Lever
@onready var file: File = $File

var next_npc: NPC
var next_chair: Sprite2D
var old_npc: NPC
var old_chair: Sprite2D

var burned_up_goats := 0
var saved_goats := 0

var names = [
	"Kid A",
	"Hermione C",
	"Subaru O",
	"Billy G",
	"Henry B",
	"Nanny Ray Cyrus",
	"Billy McPhee",
	"Nanny T. James",
	"Baaabara R",
	"LeBron J",
	"Kendrick L",
	"Shrek O",
	"R Kill",
	"Fran F",
	"Rebel Yell",
	"V Goat",
	"R Ray",
	"Couronne Lochoise",
	"S Frisk",
	"Capricorn R",
	"Phil G",
	"Jeff S",
	"M Tumnus",
	"Betty W",
	"J Bhuna",
	"Nurul S",
	"P Phillips",
	"L Gonzalo",
	"Carryl A",
	"R O'Shea",
	"V Pratley",
	"R McDonald",
	"Andrew A",
	"A Gosht",
	"Rogan J",
]

var offences = [
	"Bleating and entering",
	"Kidding around",
	"Improper pupil shape",
	"Grass slaughter",
	"Pastural assault",
	"Conspiracy to commit treason",
	"Disturbing the peace",
	"Herbicide",
	"Kidnapping",
	"Insurance fraud",
	"Identity theft",
	"Credit card fraud",
	"Parole violation",
	"Tax evasion",
	"Parking violation",
	"Brandishing head-mounted weapon",
	"Devil worship",
	"Ram and run",
	"Aggravated assault",
	"Fleecing",
	"Rambunctiousness",
	"Caught at the border",
	"Goat trafficking",
	"Possession of opioids",
]


func _ready() -> void:
	setup_next_npc()
	file.name_label.text = names.pick_random()
	file.offense_label.text = offences.pick_random()
	file.size_label.text = str(npc.current_body_type + 1)


func setup_next_npc() -> void:
	var new_chair = CHAIR.instantiate()
	new_chair.position = Vector2(800, 540)
	new_chair.z_index = -5
	add_child(new_chair)
	
	var new_npc = NPC_SCENE.instantiate()
	new_npc.has_bottom_fur = randf() > 0.5
	new_npc.has_top_fur = randf() > 0.5
	new_npc.has_left_horn = randf() > 0.5
	new_npc.has_right_horn = randf() > 0.5
	new_npc.current_body_type = randi_range(NPC.BodyType.SMALL, NPC.BodyType.LARGE)
	new_npc.face_color = Color.from_ok_hsl(0.15, 1.0, randf())
	new_npc.position = Vector2(800, 358)
	new_npc.material = new_npc.material.duplicate(true)
	new_npc.material.set_shader_parameter("radius", 0.0)
	new_npc.is_current_npc = false
	var noise: NoiseTexture2D = new_npc.material.get_shader_parameter("noiseTexture")
	noise.noise.seed = randi()
	new_npc.z_index = -5
	add_child(new_npc)
	call_deferred("reset_materials", new_npc)
	new_npc.connect("burned_up", _on_npc_burned_up)
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.set_parallel()
	tween.tween_property(new_npc, "position", Vector2(1600, npc.position.y), 3)
	tween.tween_property(new_chair, "position", Vector2(1600, chair.position.y), 3)
	
	next_chair = new_chair
	next_npc = new_npc


func _on_npc_burned_up() -> void:
	burned_up_goats += 1
	move_npc_off_screen()
	old_npc = npc
	old_chair = chair
	npc = next_npc
	chair = next_chair
	npc.is_current_npc = true
	electro_lever.connect("start_electrocution", npc._on_lever_start_electrocution)
	setup_next_npc()


func reset_materials(new_npc) -> void:
	new_npc.base_color.material = new_npc.material
	new_npc.face.material = new_npc.material
	new_npc.body.material = new_npc.material


func destroy_old_npc_chair() -> void:
	old_npc.queue_free()
	old_chair.queue_free()
	
	npc.update_shave_pos()
	electric_hat.locked_in = false
	
	lever.global_position = pivot.global_position
	lever.global_rotation = pivot.global_rotation
	
	file.name_label.text = names.pick_random()
	file.offense_label.text = offences.pick_random()
	file.size_label.text = str(npc.current_body_type)


func lose_game() -> void:
	if burned_up_goats >= 4:
		good_ending.emit()
	elif saved_goats >= 5:
		true_good_ending.emit()
	else:
		bad_ending.emit()


func move_npc_off_screen() -> void:
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.set_parallel()
	tween.tween_property(next_npc, "position", Vector2(START_X_POS, next_npc.position.y), 3)
	tween.tween_property(next_chair, "position", Vector2(START_X_POS, next_chair.position.y), 3)
	tween.set_parallel(false)
	tween.tween_property(next_npc, "z_index", 0, 0)
	tween.tween_property(next_chair, "z_index", 0, 0)
	tween.set_parallel()
	tween.tween_property(npc, "position", Vector2(-300, npc.position.y), 3)
	tween.tween_property(chair, "position", Vector2(-300, chair.position.y), 3)
	tween.tween_property(next_npc, "position", Vector2(END_X_POS, next_npc.position.y), 3)
	tween.tween_property(next_chair, "position", Vector2(END_X_POS, next_chair.position.y), 3)
	tween.tween_property(pivot, "rotation", 0, 3)
	tween.set_parallel(false)
	tween.tween_callback(destroy_old_npc_chair)


func _on_escape_goat_pressed() -> void:
	if is_instance_valid(old_npc):
		return
	saved_goats += 1
	move_npc_off_screen()
	old_npc = npc
	old_chair = chair
	npc = next_npc
	chair = next_chair
	npc.is_current_npc = true
	electro_lever.connect("start_electrocution", npc._on_lever_start_electrocution)
	setup_next_npc()
