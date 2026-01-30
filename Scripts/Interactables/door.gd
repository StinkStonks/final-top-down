extends Interactable
class_name Door

#wasnt programmed the best whatever tho it works

@export var start_open : bool = false
@onready var col : CollisionShape2D = $CollisionShape2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer

var opened : bool :
	get:
		return opened
	set(value):
		set_collision_layer_value(1, !value)
		opened = value

func interact(player : Player):
	simple_interact.emit()
	interacted.emit(player)
	
	if interacted_with and use_once:
		return
	
	open_close_door()
	interacted_with = true

#TOGGLE
func open_close_door():
	if opened: close_door()
	else: open_door()

#DIRECT FUNCTIONS
func open_door():
	animation_player.play("open")
	opened = true

func close_door():
	animation_player.play("close")
	opened = false
