class_name CardUI
extends Control

signal reparent_requested(which_card_ui: CardUI)

@export var card: Card : set = _set_card
@export var char_stats: CharacterStats

const BASE_STYLEBOX := preload("res://scenes/card_ui/card_base_stylebox.tres")
const DRAG_STYLEBOX := preload("res://scenes/card_ui/card_dragging_state.tres")
const HOVER_STYLEBOX := preload("res://scenes/card_ui/card_hover_stylebox.tres")

@onready var panel = $Panel
@onready var cost = $Cost
@onready var icon = $Icon
#drag from tree and press ctrl before release to create instance variable
@onready var drop_point_detector = $DropPointDetector
#instantiate card state machine 
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
#all current targets for cards
@onready var targets: Array[Node] = [] 

var parent: Control 
var tween: Tween

func _ready()-> void:
	#initialize card state machine
	card_state_machine.init(self)
	
#callback functions
func _input(event: InputEvent)-> void:
	card_state_machine.on_input(event)
	
func animate_to_position(new_position: Vector2, duration: float)-> void: 
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration)
	
func play() -> void:
	if not card:
		return 
		
	card.play(targets, char_stats)	
	#after playing, delete cardUI scene
	queue_free()

func _on_gui_input(event):
	card_state_machine.on_gui_input(event)
	
func _on_mouse_entered()-> void:
	card_state_machine.on_mouse_entered()
	
func _on_mouse_exited()-> void:
	card_state_machine.on_mouse_exited()
	
func _set_card(value: Card) -> void:
	if not is_node_ready():
		await ready
	
	card = value 
	cost.text = str(card.cost)
	icon.texture = card.icon

#helps cards move back to hand if released in hand section of screen
func _on_drop_point_detector_area_entered(area):
	if not targets.has(area):
		targets.append(area)

func _on_drop_point_detector_area_exited(area):
	targets.erase(area)
