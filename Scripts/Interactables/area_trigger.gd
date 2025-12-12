extends Area2D
class_name AreaTrigger

enum TriggerType {
	On_Enter,
	On_Button_Press,
	On_Exit
}

@onready var player : Player = get_tree().get_first_node_in_group('player')
@export var trigger_type : TriggerType = TriggerType.On_Enter
var player_can_interact : bool = false

signal player_triggered

#region DEBUG
@export var debug : bool = false
var debug_log_string : String : 
	get:
		return debug_log_string
	set(value):
		if debug == true:
			print(name + " " + value)
#endregion

func _process(_delta: float) -> void:
	if player_can_interact:
		if Input.is_action_just_pressed("interact"):
			trigger()

func on_enter(body : Node2D):
	if body == player:
		debug_log_string = "PLAYER ENTERED"
		if trigger_type == TriggerType.On_Button_Press:
			player_can_interact = true
			$CanvasLayer/Control/Label.visible = true
		
		if trigger_type == TriggerType.On_Enter:
			trigger()

func on_exit(body : Node2D):
	if body == player:
		debug_log_string = "PLAYER EXITED"
		if trigger_type == TriggerType.On_Button_Press:
			player_can_interact = false
			$CanvasLayer/Control/Label.visible = false
		
		if trigger_type == TriggerType.On_Exit:
			trigger()

func trigger():
	debug_log_string = "TRIGGERED"
	player_triggered.emit()
