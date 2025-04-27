extends Area2D

@onready var npc : NPC = $"../.."
@onready var face : Sprite2D = $"../Face"

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	if area is ItemRegion:
		if npc.has_bottom_fur or npc.has_top_fur or npc.has_left_horn or npc.has_right_horn or not npc.is_current_npc:
			return
		var item_region = area as ItemRegion
		if item_region.item_state == StateManager.ItemState.SPONGE:
			face.frame = 4
			npc.is_wet = true
