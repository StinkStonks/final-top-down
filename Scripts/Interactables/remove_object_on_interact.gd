extends Interactable
class_name RemoveObjectOnInteract

@export var remove_others : Array[Node]

func interact(player : Player):
	if remove_others != null:
		for object in remove_others:
			object.queue_free()
	super(player)
