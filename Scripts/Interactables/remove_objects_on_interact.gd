extends Interactable
class_name RemoveObjectsOnInteract

@export var objects : Array[Node]

func interact(player : Player):
	for object in objects:
		object.queue_free()
	super(player)
