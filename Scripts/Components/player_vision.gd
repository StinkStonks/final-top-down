extends Node2D
class_name VisionSystem

@export_category("Vision")
@export var vision_radius: float = 350.0
@export var ray_count: int = 360
@export var collision_mask: int = 1

@export_category("Field of View")
@export var use_fov: bool = false
@export_range(1, 360) var fov_degrees: float = 90.0
@export var facing_angle_offset: float = 0.0

@export_category("Debug")
@export var show_polygon: bool = true

@onready var vision_polygon: Polygon2D = $Polygon2D

func _ready():
	vision_polygon.visible = show_polygon
	vision_polygon.color = Color.WHITE

func _process(_delta):
	update_vision()

func update_vision():
	var space := get_world_2d().direct_space_state
	var points := PackedVector2Array()

	var fov_rad := deg_to_rad(fov_degrees)
	var start_angle := 0.0
	var end_angle := TAU

	if use_fov:
		var facing := global_rotation + facing_angle_offset
		start_angle = facing - fov_rad / 2.0
		end_angle = facing + fov_rad / 2.0

	for i in ray_count:
		var t := float(i) / float(ray_count - 1)
		var angle : float = lerp(start_angle, end_angle, t)

		var dir := Vector2(cos(angle), sin(angle))
		var target := global_position + dir * vision_radius

		var query := PhysicsRayQueryParameters2D.create(
			global_position,
			target,
			collision_mask
		)
		query.hit_from_inside = true

		var result := space.intersect_ray(query)

		if result:
			points.append(to_local(result.position))
		else:
			points.append(to_local(target))

	vision_polygon.polygon = points
