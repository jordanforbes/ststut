extends Node2D

@export var char_stats: CharacterStats

@onready var battle_ui: BattleUI = $BattleUI as BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler
@onready var enemy_handler: EnemyHandler = $EnemyHandler as EnemyHandler
@onready var player: Player = $Player as Player


func _ready() -> void: 
	var new_stats: CharacterStats = char_stats.create_instance()
	battle_ui.char_stats = new_stats 
	player.stats = new_stats
	
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)
	
	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.player_hand_discarded.connect(enemy_handler.start_turn)
	
	start_battle(new_stats)
	
	
func start_battle(stats: CharacterStats) -> void: 
	enemy_handler.reset_enemy_actions()
	player_handler.start_battle(stats)
	
	
func _on_enemy_turn_ended() -> void:
	player_handler.start_turn()
	enemy_handler.reset_enemy_actions()
