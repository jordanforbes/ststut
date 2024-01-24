class_name Player
extends Node2D

@export var stats: CharacterStats : set = set_character_stats

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var stats_ui: StatsUI = $StatsUI as StatsUI 


#debug
#make sure stats are connected to UI
#func _ready()-> void:
	#await get_tree().create_timer(3).timeout 
	#take_damage(3)
	#stats.block +=10
	

func set_character_stats(value: CharacterStats) -> void: 
	stats = value.create_instance()
	
	#connect signal if the signal was not already connected
		#it is possible to connect the signal twice in godot 
		#if we already have an export variable for player scene, which is bad
		#all dependencies should be set at battle node. 
		#This is good for debugging because we can test this script on its own
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		
	update_player()
	
func update_player()-> void:
	#are our stats an instance of a CharacterStats resource
	if not stats is CharacterStats: 
		return
	#make sure the node is ready
	if not is_inside_tree():
		await ready
	
	sprite_2d.texture = stats.art 
	update_stats()
	
func update_stats()-> void:
	stats_ui.update_stats(stats)
	
func take_damage(damage: int)-> void:
	#if we're already dead we can't take damage
	if stats.health <= 0:
		return 
	
	stats.take_damage(damage)
	
	#if player has 0 health they're deleted from the scene
	if stats.health <= 0:
		queue_free()
	
	
