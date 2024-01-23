class_name CardPile
extends Resource

signal card_pile_size_changed(card_amount)

@export var cards: Array[Card] = []

#checks if card pile is empty
func empty() -> bool:
	return cards.is_empty()

#draws single card
func draw_card() -> Card:
	var card = cards.pop_front()
	#emits signal to change size of card pile once one card is removed
	card_pile_size_changed.emit(cards.size())
	return card
	
#adds card to draw pile
func add_card(card: Card):
	cards.append(card)
	card_pile_size_changed.emit(cards.size())
	
#shuffle deck
func shuffle()-> void: 
	cards.shuffle()
	card_pile_size_changed.emit(cards.size())
	
	
#print card pile for debugging
func _to_string()-> String: 
	var _card_strings: PackedStringArray = []
	for i in range(cards.size()):
		_card_strings.append("%s: %s" % [i+1, cards[i].id])
	return "\n".join(_card_strings)
	
