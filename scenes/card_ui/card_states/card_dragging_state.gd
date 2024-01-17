extends CardState

func enter()-> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)
		
	card_ui.color.color = Color.NAVY_BLUE
	card_ui.state.text = "DRAGGING"

func on_input(event: InputEvent)-> void:
	var mouse_motion := event is InputEventMouseMotion 
	#card drag is cancelled if right mouse is clicked
	var cancel = event.is_action_pressed("right_mouse")
	#card is released if left mouse is let go or clicked again
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")

	if mouse_motion:
		#update card position to follow mouse cursor
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset

	if cancel:
		#when dragging is cancelled the state returns to BASE
		transition_requested.emit(self, CardState.State.BASE)
	elif confirm:
		#Prevents from instantly picking up new card
		get_viewport().set_input_as_handled()
		#transitions to RELEASED state upon confirm
		transition_requested.emit(self, CardState.State.RELEASED)
