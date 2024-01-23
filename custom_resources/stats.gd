class_name Stats
extends Resource

signal stats_changed

@export var max_health := 1
@export var art: Texture 

var health: int : set = set_health 
var block: int : set = set_block

func set_health(value: int)-> void:
	#prevents health from going over max or under 0 
	health = clampi(value, 0, max_health )
	stats_changed.emit()
	
func set_block(value: int)-> void:
	#prevents block from going over max(999)
	block = clampi(value, 0, 999)
	stats_changed.emit()
	
func take_damage(damage: int)-> void:
	#if no damage, exit function
	if damage <= 0:
		return 
	#calculates actual damage taken
	var initial_damage = damage 
	#subtracts block from damage to get actual damage
	damage = clampi(damage - block, 0, damage)
	#how much block is left?	
	self.block = clampi(block - initial_damage, 0, block)
	#subtracts damage from health	
	self.health -= damage

func heal(amount: int)-> void:
	self.health += amount
	
#creates new instance of enemy disconnected from other ones
func create_instance() -> Resource: 
	var instance: Stats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	return instance
