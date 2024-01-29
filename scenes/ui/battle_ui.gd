class_name BattleUI
extends CanvasLayer

@export var char_stats: CharacterStats : set = _set_char_stats

@onready var hand: Hand = $Hand as Hand 
@onready var mana_ui: ManaUI = $ManaUI as ManaUI

func _set_char_stats(value: CharacterStats) -> void: 
	char_stats = value 
	mana_ui.char_stats = char_stats
	hand.char_stats = char_stats
