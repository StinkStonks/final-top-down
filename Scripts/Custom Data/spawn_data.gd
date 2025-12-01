extends Resource
class_name SpawnData

#Honestly dont know if this is the best way to program this...

enum PoolType {
	Common,
	Uncommon,
	Rare,
	Epic
}

@export var common_spawn_pool : Array[PackedScene]
@export var uncommon_spawn_pool : Array[PackedScene]
@export var rare_spawn_pool : Array[PackedScene]
@export var epic_spawn_pool : Array[PackedScene]

var pools : Array[Array] = [common_spawn_pool, uncommon_spawn_pool, rare_spawn_pool, epic_spawn_pool]

@export var common_spawn_chance = 50
@export var uncommon_spawn_chance = 25
@export var rare_spawn_chance = 15 
@export var epic_spawn_chance = 5 

#this is ugly
func get_random_object_from_pool() -> Node2D:
	var pool : Array = pools[get_pool()]
	return pool[randi_range(0, pools.size())]

func get_pool() -> PoolType:
	var chance = randf_range(0, 100)
	
	if chance <= common_spawn_chance:
		return PoolType.Common
	elif chance <= common_spawn_chance + uncommon_spawn_chance:
		return PoolType.Uncommon
	elif chance <= common_spawn_chance + uncommon_spawn_chance + rare_spawn_chance:
		return PoolType.Rare
	else:
		return PoolType.Epic
