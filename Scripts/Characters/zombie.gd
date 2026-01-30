extends CharacterBody2D
class_name Zombie

@onready var agent : NavigationAgent2D = $NavigationAgent2D
@onready var health_component : HealthComponent = $HealthComponent
@onready var graphics : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var timer : Timer = $Timer
@onready var state_machine : StateMachine = $StateMachine
@export var speed = 100

@export_group("AI PROPERTIES")
@export var target : Node2D
@export var detection_range : float = 200
@export var attack_range : float = 40
signal died

func _ready() -> void:
	health_component.connect("died", kill)
	state_machine.change_state("Idle")

func _process(_delta: float) -> void:
	graphics.look_at(agent.get_next_path_position())

#This might slow down the game in the long run
func kill() -> void:
	graphics.play("dead")
	
	died.emit()
	rotation_degrees = randf_range(0, 360)
	collision_layer = 0
	collision_mask = 0
	z_index = -1
	
	state_machine.set_process(false)
	set_process(false)
	set_physics_process(false)
	
	await get_tree().create_timer(120).timeout
	queue_free()

func on_target_spotted(_target: Node2D) -> void:
	target = _target

func _on_target_lost() -> void:
	state_machine.change_state("Idle")
	target = null
