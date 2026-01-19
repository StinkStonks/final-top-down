extends Area2D
class_name VisionManager

signal target_spotted(_target : Node2D)
signal target_lost

func body_entered(body : Node2D):
	if body is Player:
		target_spotted.emit(body)

func body_exited(body : Node2D):
	if body is Player:
		target_lost.emit()
