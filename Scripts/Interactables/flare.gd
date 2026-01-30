extends RigidBody2D
class_name Flare

@onready var point_light : PointLight2D = $PointLight2D

@export var freeze_velocity_time : float = 1
@export var min_energy : float = 0.5
@export var max_energy : float = 1.5
@export var flicker_speed : float = 5
@export var fadeout_speed : float = 1

var target_energy := 1.0
var fading_out : bool = false

func _ready():
	target_energy = point_light.energy
	await get_tree().create_timer(freeze_velocity_time).timeout
	linear_velocity = Vector2.ZERO
	angular_velocity = 0

func _process(delta):
	point_light.energy = lerp(point_light.energy, target_energy, delta * flicker_speed)
	
	if fading_out:
		target_energy = 0.0
	else:
		if randi() % 5 == 0:
			target_energy = randf_range(min_energy, max_energy)

func unlight_flare():
	fading_out = true
