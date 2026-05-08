extends CharacterBody2D
class_name Zombie

@export var speed : float = 80
@export var attack_range : float = 20
@export var score_to_add_range : Vector2 = Vector2(20, 35)

@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var health = $HealthComponent
@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D
@onready var player : Node2D 

var active : bool

func _ready():
	player = get_tree().get_first_node_in_group("player")
	nav_agent.target_desired_distance = 4.0
	deactivate()

func activate(spawn_position:Vector2):
	global_position = spawn_position
	collision.disabled = false
	set_process(true)
	set_physics_process(true)
	show()

func deactivate():
	global_position = Vector2(0,0)
	collision.disabled = true
	set_process(false)
	set_physics_process(false)
	hide()

func _process(delta: float) -> void:
	look_at(nav_agent.get_next_path_position())

func _physics_process(delta):
	if not player:
		return
	
	nav_agent.target_position = player.global_position

	var next_point = nav_agent.get_next_path_position()
	var direction = (next_point - global_position).normalized()

	velocity = direction * speed

	# Stop moving if close enough (attack range)
	if global_position.distance_to(player.global_position) <= attack_range:
		velocity = Vector2.ZERO
		attack()
	
	move_and_slide()

func kill():
	var zombie_pool : ZombiePool = get_tree().current_scene.get_node("ZombiePool") 
	GameManager.add_score(randi_range(score_to_add_range.x, score_to_add_range.y))
	zombie_pool.return_zombie(self)

func attack():
	look_at(player.global_position)
	print("Zombie attacking!")
