extends Node2D

@export var char_stats: CharacterStats

@onready var battle_ui: BattleUI = $BattleUI as BattleUI

func _ready() -> void: 
	var new_stats: CharacterStats = char_stats.create_instance()
	battle_ui.char_stats = new_stats 
	
	start_battle(new_stats)
	
func start_battle(stats: CharacterStats) -> void: 
	print("battle has started")
