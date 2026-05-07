extends Node
class_name StateMachine

var current_state : AIState
var character : CharacterBody2D
var agent : NavigationAgent2D

func _ready() -> void:
	character = get_parent()
	
	for child in get_children():
		child.character = character
		child.state_machine = self

func change_state(state_name: String):
	if current_state:
		current_state.exit()
	
	current_state = get_node("AI_" + state_name) as AIState
	current_state.enter()

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func alert():
	if current_state == get_node("AI_Chase"):
		return
	var chase_state : AI_Chase = get_node("AI_Chase")
	chase_state.target_last_position = get_tree().get_first_node_in_group("player").global_position
	change_state("Chase")
