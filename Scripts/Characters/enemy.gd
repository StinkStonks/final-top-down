@abstract 
extends CharacterBody2D
class_name Enemy

@onready var agent : NavigationAgent2D = $NavigationAgent2D
@onready var health_component : HealthComponent = $HealthComponent
@onready var graphics : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var timer : Timer = $Timer
@onready var vision_manager : VisionManager = $VisionManager

@export var speed = 100
@export var health = 50
@export var player_position_always_known : bool = false

var chasing_player = false

signal died

func _ready() -> void:
	health_component.connect("died", kill)

func _physics_process(delta: float) -> void:
	control_motion(delta)

@abstract
func update_ai() -> void

@abstract
func control_motion(delta : float) -> void

func kill() -> void:
	graphics.play("dead")
	
	died.emit()
	rotation_degrees = randf_range(0, 360)
	collision_layer = 0
	collision_mask = 0
	z_index = -1
	
	set_process(false)
	set_physics_process(false)
	
	await get_tree().create_timer(120).timeout
	queue_free()
