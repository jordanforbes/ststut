extends CardState

#has card been played or not
var played: bool

func enter()-> void:
	#initially, card has of course not been played
	played = false
	Events.tooltip_hide_requested.emit()
	
	#if, when card is released, there is a valid target, then the card is played
	if not card_ui.targets.is_empty():
		played = true
		card_ui.play()


func on_input(event: InputEvent)-> void:
	#if card is played then we don't really care about additional input
	if played:
		return
		
	#if no valid target, card returns to BASE state
	transition_requested.emit(self, CardState.State.BASE)
	
