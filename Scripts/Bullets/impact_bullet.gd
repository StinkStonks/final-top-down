extends BasicBullet
class_name ImpactBullet

@export var impact_effect : PackedScene

func _process(delta: float) -> void:
	super(delta)

func body_entered(body : Node2D):
	var new_effect : Node2D = impact_effect.instantiate()
	new_effect.global_position = global_position
	queue_free()
