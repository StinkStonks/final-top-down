extends Node2D
class_name InteractionManager

@onready var interaction_raycast : RayCast2D = $InteractionRaycast

var focused_interactable : Interactable = null

signal has_interactable(interactable : Interactable)
signal lost_interactable

func _physics_process(delta: float) -> void:
	if interaction_raycast.is_colliding():
		var collider = interaction_raycast.get_collider()
		
		if collider is Interactable:
			var interactable : Interactable = collider
			focused_interactable = interactable
	elif !interaction_raycast.is_colliding() and focused_interactable != null:
		lose_interactable()

func focus_interactable(interactable : Interactable):
	focused_interactable = interactable
	has_interactable.emit(interactable)

func lose_interactable():
	lost_interactable.emit()
	focused_interactable = null

func interact():
	if focused_interactable:
		focused_interactable.interact($"..")
