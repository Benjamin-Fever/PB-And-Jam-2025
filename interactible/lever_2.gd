class_name ElectrocutionLever 
extends Interaction


signal start_electrocution

@onready var flick_animator: AnimationPlayer = $FlickAnimator
@onready var npc: NPC = $"../NPC"


func interact_with() -> void:
	if npc.has_bottom_fur or npc.has_top_fur or npc.has_left_horn or npc.has_right_horn:
		return
	flick_animator.play("flick")


func _on_flick_animator_animation_finished(_anim_name: StringName) -> void:
	start_electrocution.emit()
