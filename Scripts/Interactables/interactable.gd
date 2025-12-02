extends Area2D
class_name Interactable

@export var interactable_name : String = 'New Interactable'
@export var use_once : bool = true

signal interacted(player:Player)

func interact(player : Player):
	interacted.emit(player)
	if use_once:
		queue_free()
