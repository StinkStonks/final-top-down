@abstract
extends CharacterBody2D
class_name Character

const DEFAULT_MOVE_SPEED : float = 50
const DEFAULT_ACCEL : float = 0.1
const DEFAULT_FRICTION : float = 0.1

@onready var originial_speed : float = move_speed

@export var move_speed : float = DEFAULT_MOVE_SPEED
@export var rotate_speed : float = 4
@export var accel : float = DEFAULT_ACCEL
@export var friction : float = DEFAULT_FRICTION
@export var head_limit_deg : float = 90
@export var focus_rotate_speed : float = 10
@onready var head = $Head

var focused : bool = false

signal _focused_changed(focus : bool)
signal _focused
signal _unfocused

func _process(delta: float) -> void:
	var desired_angle = (control_character_head() - head.global_position).angle()
	var body_angle = global_rotation
	
	var limit_rad = deg_to_rad(head_limit_deg)
	var relative_angle = wrapf(desired_angle - body_angle, -PI, PI)
	var clamped_relative = clamp(relative_angle, -limit_rad, limit_rad)
	var final_angle = body_angle + clamped_relative

	head.global_rotation = final_angle
	
	if focused:
		global_rotation = lerp_angle(global_rotation, head.global_rotation, focus_rotate_speed * delta)

func _physics_process(delta: float) -> void:
	var movement_input = control_character_body().normalized()
	global_rotation += movement_input.x * rotate_speed * delta
	
	if movement_input.y > 0:
		velocity.x = lerp(velocity.x, movement_input.x, accel)
	else:
		velocity.x = lerpf(velocity.x, 0, friction)
	
	velocity = transform.x * movement_input.y * move_speed
	
	move_and_slide()

func change_focus(new_focus : bool):
	if new_focus != focused:
		_focused_changed.emit(new_focus)
		print(new_focus)
	
	if !new_focus and focused:
		focused = false
		_unfocused.emit()
	elif !focused and new_focus:
		focused = true
		_focused.emit()

@abstract
func control_character_body() -> Vector2

@abstract
func control_character_head() -> Vector2
