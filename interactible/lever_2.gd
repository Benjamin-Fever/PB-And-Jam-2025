class_name ElectrocutionLever 
extends Interaction


signal start_electrocution

@onready var flick_animator: AnimationPlayer = $FlickAnimator
@onready var npc: NPC = $"../NPC"
@onready var electric_hat: ElectricHat = $"../ElectricHat"
@onready var pivot: Node2D = $"../Interactables/Voltage/Pivot"


func interact_with() -> void:
	if not is_instance_valid(npc):
		npc = $"..".npc
	if npc.has_bottom_fur or npc.has_top_fur or npc.has_left_horn or npc.has_right_horn or not electric_hat.locked_in or pivot.rotation_degrees < 140:
		return
	AudioManager.play_sound("res://assets/audio/electrocute.mp3")
	flick_animator.play("flick")


func _on_flick_animator_animation_finished(_anim_name: StringName) -> void:
	start_electrocution.emit()
