extends Node2D
class_name InteractionManager

@onready var interaction_raycast : RayCast2D = $InteractionRaycast

var focused_interactable : Interactable = null

signal has_interactable(interactable : Interactable)
signal lost_interactable

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		if focused_interactable != null:
			focused_interactable.interact($"..")
			if focused_interactable.use_once:
				lost_interactable.emit()

func _physics_process(_delta: float) -> void:
	interaction_raycast.force_raycast_update()
	if interaction_raycast.is_colliding():
		var collider = interaction_raycast.get_collider()
		
		if collider is Interactable and collider != focused_interactable:
			focus_interactable(collider)
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
