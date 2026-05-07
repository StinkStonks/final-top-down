extends Node
class_name ZombiePool

static var instance : ZombiePool

@export var zombie_scene : PackedScene = preload("res://Prefabs/Characters/zombie.tscn")
@export var pool_size : int = 50

var inactive_zombies : Array[Zombie] = []
var active_zombies : Array[Zombie] = []

func _ready():
	instance = self
	create_pool()

func create_pool():
	#add pool objects to pool node
	for i in pool_size:
		var zombie : Zombie = zombie_scene.instantiate() 
		add_child.call_deferred(zombie)
		inactive_zombies.append(zombie)
		print(i)

func get_zombie(spawn_position : Vector2) -> Zombie:
	if inactive_zombies.is_empty():
		print("No zombies available in pool")
		return null
	
	var zombie = inactive_zombies.pop_back()
	active_zombies.append(zombie)
	zombie.activate(spawn_position)
	return zombie

static func return_zombie(zombie : Zombie):
	if instance == null:
		return
	
	if zombie in instance.active_zombies:
		instance.active_zombies.erase(zombie)
	
	zombie.deactivate.call_deferred()
	
	instance.inactive_zombies.append(zombie)


func spawn_zombies(amount : int, position : Vector2, area : float):
	for i in amount:
		var spawn_position = position + random_point_in_circle(area)
		ZombiePool.instance.get_zombie.call_deferred(spawn_position)

func random_point_in_circle(radius : float) -> Vector2:
	var angle = randf() * TAU
	var distance = sqrt(randf()) * radius

	return Vector2(
		cos(angle),
		sin(angle)
	) * distance
