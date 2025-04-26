@tool
class_name Setting
extends HBoxContainer


@export var title: String:
	set(value):
		title = value
		if label:
			label.text = title

@onready var label: Label = $Label


func _ready() -> void:
	label.text = title
