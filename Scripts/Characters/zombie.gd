extends CharacterBody2D
class_name Zombie

@onready var agent : NavigationAgent2D = $NavigationAgent2D
@onready var health_component : HealthComponent = $HealthComponent
@onready var graphics : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var timer : Timer = $Timer

@export var speed = 100
@export var health = 50
@export var player_position_always_known : bool = false

signal died

func _ready() -> void:
	health_component.connect("died", kill)

func _physics_process(delta: float) -> void:
	var direction = to_local(agent.get_next_path_position()).normalized()
	
	velocity = direction * speed
	
	move_and_slide()

func _process(_delta: float) -> void:
	graphics.look_at(agent.get_next_path_position())

func update_ai():
	if player_position_always_known:
		var player : NewPlayer = get_tree().get_first_node_in_group("player")
		agent.target_position = player.global_position

func kill():
	died.emit()
	
	graphics.play("dead")
	rotation_degrees = randf_range(0, 360)
	collision_layer = 0
	collision_mask = 0
	z_index = -1
	
	set_process(false)
	set_physics_process(false)
	
	await get_tree().create_timer(120).timeout
	queue_free()
