class_name Player
extends CharacterBody2D

@onready var health_component : HealthComponent = $HealthComponent
@onready var weapon_holder : WeaponHolder = $WeaponHolder

@export var enabled : bool = false

@export_subgroup('Movement')
@export var speed : float = 400
@export var acceleration = 0.1
@export var friction = 0.1

signal died

func enable(b : bool):
	enabled = b
	visible = b
	set_physics_process(b)
	set_process(b)

func _ready():
	enable(enabled)

func _physics_process(_delta):
	var move = get_input()
	
	if move.length() > 0:
		velocity = lerp(velocity, move.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
	
	look_at(get_global_mouse_position())
	move_and_slide()

func get_input():
	var input = Vector2()
	
	#Movement
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	
	if Input.is_action_pressed("shoot"):
		weapon_holder.shoot()
	
	if Input.is_action_just_pressed("reload"):
		weapon_holder.reload_weapon()
	
	if Input.is_action_just_pressed("switch_weapon"):
		weapon_holder.switch_weapon()
	
	return input

func kill():
	died.emit()
	enable(false)
