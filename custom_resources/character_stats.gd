class_name CharacterStats
extends Stats

@export var starting_deck: CardPile 
@export var cards_per_turn: int 
@export var max_mana: int

var mana: int :  set = set_mana 
var deck: CardPile 
var discard: CardPile 
var draw_pile: CardPile 

#no clamp function because you can go over the limit of energy 
func set_mana(value: int)-> void:
	mana = value 
	stats_changed.emit()
	
func reset_mana() -> void:
	self.mana = max_mana 
	
#do we have enough mana to play a card?
func can_play_card(card: Card) -> bool:
	return mana >= card.cost

#duplicate functions are to prevent the starting deck from being permanently altered
func create_instance() -> Resource:
	var instance: CharacterStats = self.duplicate()
	instance.health = max_health 
	instance.block = 0 
	instance.reset_mana()
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance 
