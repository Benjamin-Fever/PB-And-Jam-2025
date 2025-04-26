class_name ElectrocutionLever 
extends Interaction


signal start_electrocution

@onready var flick_animator: AnimationPlayer = $FlickAnimator


func interact_with() -> void:
	flick_animator.play("flick")


func _on_flick_animator_animation_finished(anim_name: StringName) -> void:
	start_electrocution.emit()
