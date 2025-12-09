extends Zombie
class_name ZombieBloater

@export var explode_radius : float = 100
@export var explosion_damage : float = 10

func kill() -> void:
	var nearby = get_objects_nearby(explode_radius)
	
	for object : Node2D in nearby:
		var raycast_result : Node2D = cast_ray(global_position, object.global_position)
		
		if raycast_result.has_node("HealthComponent"):
			var result_health_component : HealthComponent = raycast_result.get_node("HealthComponent")
			var damage_data : DamageData = DamageData.new()
			damage_data.amount = explosion_damage
			
			result_health_component.take_damage(damage_data)
	super()

func get_objects_nearby(radius: float) -> Array:
	var space = get_world_2d().direct_space_state
	
	var shape = CircleShape2D.new()
	shape.radius = radius
	
	var params = PhysicsShapeQueryParameters2D.new()
	params.shape = shape
	params.transform = Transform2D(0, global_position)
	params.collision_mask = [1,2,3]
	var results = space.intersect_shape(params)
	
	return results

func cast_ray(from: Vector2, to: Vector2) -> Node2D:
	var space = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(from, to)
	var result : Node2D = space.intersect_ray(query).collider
	
	return result
