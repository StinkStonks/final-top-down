extends Area2D
class_name ImpactEffectAreaDamage

@export var damage : float = 10

func _ready() -> void:
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.has_node("HealthComponent"):
			var health_component : HealthComponent = body.health_component
			var damage_data : DamageData = DamageData.new()
			damage_data.amount = damage
			damage_data.hit_direction = 0
			health_component.take_damage(damage_data)
	queue_free()
