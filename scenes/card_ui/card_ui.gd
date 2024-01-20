class_name CardUI
extends Control

signal reparent_requested(which_card_ui: CardUI)

@export var card: Card

@onready var color: ColorRect = $Color
@onready var state: Label = $State
#drag from tree and press ctrl before release to create instance variable
@onready var drop_point_detector = $DropPointDetector
#instantiate card state machine 
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
#all current targets for cards
@onready var targets: Array[Node] = [] 

func _ready()-> void:
	#initialize card state machine
	card_state_machine.init(self)
	
#callback functions
func _input(event: InputEvent)-> void:
	card_state_machine.on_input(event)
	
func _on_gui_input(event):
	card_state_machine.on_gui_input(event)
	
func _on_mouse_entered()-> void:
	card_state_machine.on_mouse_entered()
	
func _on_mouse_exited()-> void:
	card_state_machine.on_mouse_exited()

#helps cards move back to hand if released in hand section of screen
func _on_drop_point_detector_area_entered(area):
	if not targets.has(area):
		targets.append(area)

func _on_drop_point_detector_area_exited(area):
	targets.erase(area)
