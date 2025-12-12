extends CharacterBody2D
class_name Zombie

@onready var agent : NavigationAgent2D = $NavigationAgent2D
@onready var health_component : HealthComponent = $HealthComponent
@onready var graphics : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var timer : Timer = $Timer
@onready var vision_manager : VisionManager = $VisionManager

@export var speed = 100
@export var player_position_always_known : bool = false

var chasing_player = false

signal died

func _ready() -> void:
	health_component.connect("died", kill)

func _physics_process(delta: float) -> void:
	control_motion(delta)

func _process(_delta: float) -> void:
	graphics.look_at(agent.get_next_path_position())
	
@onready var desired_target_position : Vector2 = global_position
func update_ai():
	var player_spotted : bool = vision_manager.player_spotted()
	var player_position : Vector2 = get_tree().get_first_node_in_group('player').global_position
	
	if player_position_always_known:
		desired_target_position = get_tree().get_first_node_in_group('player').global_position
	
	if player_spotted and !chasing_player:
		chasing_player = true
		desired_target_position = get_tree().get_first_node_in_group('player').global_position
	
	elif !player_spotted and chasing_player:
		chasing_player = false
		desired_target_position = global_position
	
	agent.target_position = desired_target_position

func control_motion(_delta:float):
	var direction = to_local(agent.get_next_path_position()).normalized()
	velocity = direction * speed
	move_and_slide()

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
