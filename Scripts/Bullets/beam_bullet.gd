extends RayCast2D

@onready var Line : Line2D = $Line2D

@export var damage : float = 25

func _ready():
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(Line, 'width', 10, 0.2)
	tween.tween_property(Line, 'width', 0, 0.1)
	

func _physics_process(delta):
	force_raycast_update()
	if is_colliding():
		target_position = to_local(get_collision_point())
		var collider = get_collider()
		if collider.has_node("HealthComponent") && collider != get_tree().get_first_node_in_group('player'):
			var hc : HealthComponent = collider.health_component
			var damage_data : DamageData = DamageData.new()
			
			damage_data.amount = damage
			damage_data.hit_direction = -rotation_degrees
			
			hc.take_damage(damage_data)
	Line.points[1] = target_position
	if Line.width <= 0:
		queue_free()
	
	enabled = false
