extends Node2D
class_name Interactable

@export var interactable_name : String = 'New Interactable'
@export var use_once : bool = true

signal interacted(player:Player)
signal simple_interact

func interact(player : Player):
	simple_interact.emit()
	interacted.emit(player)
	if use_once:
		queue_free()
