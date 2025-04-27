class_name Main
extends Node2D


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


func _on_npc_burned_up() -> void:
	timer_label.reset_timer()
	
	var new_chair = CHAIR.instantiate()
	new_chair.position = Vector2(START_X_POS, 540)
	add_child(new_chair)
	
	var new_npc = NPC_SCENE.instantiate()
	new_npc.has_bottom_fur = randf() > 0.5
	new_npc.has_top_fur = randf() > 0.5
	new_npc.has_left_horn = randf() > 0.5
	new_npc.has_right_horn = randf() > 0.5
	new_npc.current_body_type = randi_range(NPC.BodyType.SMALL, NPC.BodyType.LARGE)
	new_npc.face_color = Color.from_ok_hsl(0.15, 1.0, randf())
	new_npc.position = Vector2(START_X_POS, 358)
	new_npc.material = new_npc.material.duplicate(true)
	new_npc.material.set_shader_parameter("radius", 0.0)
	add_child(new_npc)
	call_deferred("reset_materials", new_npc)
	new_npc.connect("burned_up", _on_npc_burned_up)
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.set_parallel()
	tween.tween_property(npc, "position", Vector2(-300, npc.position.y), 3)
	tween.tween_property(chair, "position", Vector2(-300, chair.position.y), 3)
	tween.tween_property(new_npc, "position", Vector2(END_X_POS, new_npc.position.y), 3)
	tween.tween_property(new_chair, "position", Vector2(END_X_POS, new_chair.position.y), 3)
	tween.tween_property(pivot, "rotation", 0, 3)
	tween.set_parallel(false)
	tween.tween_callback(destroy_old_npc_chair.bind(new_npc, new_chair))


func reset_materials(new_npc) -> void:
	new_npc.base_color.material = new_npc.material
	new_npc.face.material = new_npc.material
	new_npc.body.material = new_npc.material


func destroy_old_npc_chair(new_npc, new_chair) -> void:
	npc.queue_free()
	chair.queue_free()
	npc = new_npc
	chair = new_chair
	
	npc.update_shave_pos()
	electric_hat.locked_in = false
	
	lever.global_position = pivot.global_position
	lever.global_rotation = pivot.global_rotation


func lose_game() -> void:
	print("Wow, you lost!")
