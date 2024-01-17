extends CardState

func enter()-> void:
	card_ui.color.color = Color.ORANGE
	card_ui.state.text = "CLICKED"
	card_ui.drop_point_detector.monitoring = true #check for collision with card area
	
func on_input(event: InputEvent)-> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING) 
		#when card is clicked and mouse moves it transitions to dragging state
