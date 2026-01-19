extends CollisionObject2D
class_name Interactable

#VARIBLES
@export var interactable_name : String = 'New Interactable'
@export var use_once : bool = true
var interacted_with : bool = false

#SIGNALS 
signal interacted(player:Player)
signal simple_interact

#SKELETON STRUCTURE FOR INTERACT FUNCTION
#EMITS SIMPLE_INTERACT AND INTERACTED
#SIMPLE IS USED FOR CALLING OTHER FUNCTIONS WITHOUT PASSING ARGS INTO IT
#INTERACTED IS USED FOR CALLING FUNCTIONS WITH THE PLAYER AS AND ARG
func interact(player : Player):
	simple_interact.emit()
	interacted.emit(player)
	interacted_with = true
	if use_once:
		queue_free()
