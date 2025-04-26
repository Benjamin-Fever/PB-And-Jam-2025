extends Node2D

enum NPCFeatures {
	FUR,
	LHORN,
	RHORN
}

@export var fur_color : Color = Color(1, 1, 1)
@export var face_color : Color = Color(1, 1, 1)
@export var has_left_horn: bool = true
@export var has_right_horn: bool = true
@export var has_fur: bool = true


@export_group("Refrences")
@export var fur_sprite : Sprite2D
@export var face_sprite : Sprite2D
@export var left_horn : Node2D
@export var right_horn : Node2D

var features = [
	NPCFeatures.FUR,
	NPCFeatures.LHORN,
	NPCFeatures.RHORN
]

func _ready():
	_update();


func _update():
	fur_sprite.modulate = fur_color
	face_sprite.modulate = face_color
	fur_sprite.visible = has_fur
	left_horn.visible = has_left_horn
	right_horn.visible = has_right_horn
