class_name CardStateMachine 
extends Node 

@export var initial_state: CardState 

var current_state: CardState
var states = {}

func init(card: CardUI)->void:
	#if current child is a card state adds child to dictionary	
	for child in get_children():
		if child is CardState:
			states[child.state]=child 
			child.transition_requested.connect(_on_transition_requested)
			child.card_ui = card
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state 
		
#if there is an active current state, calls corresponding function
func on_input(event: InputEvent)-> void:
	if current_state:
		current_state.on_input(event)
		
func on_gui_input(event: InputEvent)-> void:
	if current_state:
		current_state.on_gui_input(event)
		
func _on_transition_requested(from: CardState, to: CardState.State)-> void:
	#if two states are mismatching then there was an error
	if from != current_state:
		return
		
	#store reference to new state		
	var new_state: CardState = states[to]
	if not new_state:
		return

	#if new state exists then current state is exited
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
