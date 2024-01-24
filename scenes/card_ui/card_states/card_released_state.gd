extends CardState

#has card been played or not
var played: bool

func enter()-> void:
	#initially, card has of course not been played
	played = false
	
	#if, when card is released, there is a valid target, then the card is played
	if not card_ui.targets.is_empty():
		played = true
		print("play card for target(s) ", card_ui.targets)	


func on_input(event: InputEvent)-> void:
	#if card is played then we don't really care about additional input
	if played:
		return
		
	#if no valid target, card returns to BASE state
	transition_requested.emit(self, CardState.State.BASE)
	
