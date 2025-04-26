class_name Main
extends Node2D


const START_X_POS = 2300
const END_X_POS = 950

const NPC_SCENE = preload("res://npc/npc.tscn")
const CHAIR = preload("res://npc/chair.tscn")


@onready var npc: NPC = $NPC
@onready var chair: Sprite2D = $Chair


func _on_npc_burned_up() -> void:
	var new_chair = CHAIR.instantiate()
	new_chair.position = Vector2(START_X_POS, 540)
	add_child(new_chair)
	
	var new_npc = NPC_SCENE.instantiate()
	new_npc.has_bottom_fur = randf() > 0.5
	new_npc.has_top_fur = randf() > 0.5
	new_npc.has_left_horn = randf() > 0.5
	new_npc.has_right_horn = randf() > 0.5
	new_npc.current_body_type = randi_range(NPC.BodyType.SMALL, NPC.BodyType.LARGE)
	new_npc.position = Vector2(START_X_POS, 358)
	add_child(new_npc)
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.set_parallel()
	tween.tween_property(npc, "position", Vector2(-300, npc.position.y), 3)
	tween.tween_property(chair, "position", Vector2(-300, chair.position.y), 3)
	tween.tween_property(new_npc, "position", Vector2(END_X_POS, new_npc.position.y), 3)
	tween.tween_property(new_chair, "position", Vector2(END_X_POS, new_chair.position.y), 3)
	tween.set_parallel(false)
	tween.tween_callback(destroy_old_npc_chair.bind(new_npc, new_chair))


func destroy_old_npc_chair(new_npc, new_chair) -> void:
	npc.queue_free()
	chair.queue_free()
	npc = new_npc
	chair = new_chair
