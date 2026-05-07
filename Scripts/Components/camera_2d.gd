extends Camera2D

var shake_strength: float = 0.0
var shake_decay: float = 5.0
var shake_offset: Vector2 = Vector2.ZERO
var noise := FastNoiseLite.new()
var time := 0.0

func _ready():
	noise.seed = randi()
	noise.frequency = 10.0

func _process(delta):
	time += delta
	
	if shake_strength > 0:
		var x = noise.get_noise_2d(time, 0)
		var y = noise.get_noise_2d(0, time)
		
		offset = Vector2(x, y) * shake_strength
		
		shake_strength = lerp(shake_strength, 0.0, shake_decay * delta)
	else:
		offset = Vector2.ZERO

func shake(amount: float):
	shake_strength = max(shake_strength, amount)

func shake_from_gun_shot(weapon:WeaponData):
	shake(weapon.recoil)
