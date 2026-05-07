extends CharacterBody2D
class_name Player

const DEFAULT_MOVE_SPEED : float = 240
const DEFAULT_ACCEL : float = 0.1
const DEFAULT_FRICTION : float = 0.1

@onready var health_component : HealthComponent = $HealthComponent
@onready var weapon_holder : WeaponHolder = $WeaponHolder
@onready var originial_speed : float = move_speed

@export var sprint_speed : float = DEFAULT_MOVE_SPEED * 1.2
@export var focused_speed : float = DEFAULT_MOVE_SPEED * 0.25
@export var move_speed : float = DEFAULT_MOVE_SPEED
@export var accel : float = DEFAULT_ACCEL
@export var friction : float = DEFAULT_FRICTION

var focused : bool = false

signal died

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		weapon_holder.shoot()
	if Input.is_action_pressed("sprint"):
		move_speed = sprint_speed
	else:
		move_speed = originial_speed
	
	if focused:
		if Input.is_action_pressed("shoot"):
			weapon_holder.shoot()

	
func _input(event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("reload"):
		weapon_holder.reload_weapon()

func _physics_process(delta: float) -> void:
	var movement_input = control_character_body().normalized()
	
	velocity = movement_input * move_speed
	
	look_at(get_global_mouse_position())
	
	move_and_slide()

func kill():
	died.emit()
	queue_free()

func control_character_body() -> Vector2:
	if Input.is_action_just_pressed("reload"):
		weapon_holder.reload_weapon()
	
	if Input.is_action_just_pressed("switch_weapon"):
		weapon_holder.switch_weapon()
	
	
	return Input.get_vector("left","right","up","down").normalized() * move_speed

func control_character_head() -> Vector2:
	return get_global_mouse_position()
