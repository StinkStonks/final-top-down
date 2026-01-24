extends Character
class_name Player

@onready var health_component : HealthComponent = $HealthComponent
@onready var weapon_holder : WeaponHolder = $WeaponHolder

@export var sprint_speed : float = DEFAULT_MOVE_SPEED * 1.2
@export var focused_speed : float = DEFAULT_MOVE_SPEED * 0.25

func _process(delta: float) -> void:
	change_focus(Input.is_action_pressed("focus"))
	
	if focused:
		move_speed = focused_speed
	elif !focused and is_sprinting():
		move_speed = sprint_speed
	else:
		move_speed = originial_speed
	
	if focused:
		if Input.is_action_pressed("shoot"):
			weapon_holder.shoot()
	
	super(delta)

func control_character_body() -> Vector2:
	if Input.is_action_just_pressed("reload"):
		weapon_holder.reload_weapon()
	
	if Input.is_action_just_pressed("switch_weapon"):
		weapon_holder.switch_weapon()
	
	return Input.get_vector("left", "right", "down", "up")

func control_character_head() -> Vector2:
	return get_global_mouse_position()

func is_sprinting() -> bool:
	return Input.is_action_pressed("sprint")
