extends PointLight2D
class_name FlickerLight

@export var min_energy := 0.5
@export var max_energy := 1.5
@export var flicker_speed := 5.0  # Higher is faster

var target_energy := 1.0

func _ready():
	target_energy = energy

func _process(delta):
	energy = lerp(energy, target_energy, delta * flicker_speed)
	
	if randi() % 5 == 0:
		target_energy = randf_range(min_energy, max_energy)

func fade_out(fade_out_speed : float):
	target_energy = lerp(target_energy, 0, delta * fade_out_speed)
