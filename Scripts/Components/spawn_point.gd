extends Node2D
class_name SpawnPoint

enum SpawnType {
	Instant,
	Instant_Timer,
	On_Signal,
	On_Signal_Timer,
}

enum SpawnBehavior {
	First_Object_Only,
	Sequence,
	Random
}

@export var spawn_type : SpawnType = SpawnType.Instant
@export var spawn_behavior : SpawnBehavior = SpawnBehavior.First_Object_Only
@export var possible_objects_to_spawn : Array[PackedScene]
var current_spawn_object : int : 
	get:
		return current_spawn_object
	set(value):
		value = wrapi(value, 0, possible_objects_to_spawn.size())
		current_spawn_object = value

@export_group("Timer Options")
@export var time_out : float = 1
@export var loop : bool = false
var timer : Timer

#region DEBUG OPTIONS
@export_group("Debug")
@export var debug : bool = false
var debug_log_string : String :
	get:
		return debug_log_string
	set(value):
		if debug == true:
			print(name + " " + value)
#endregion

signal object_spawned(object : Node2D)

func _ready() -> void:
	if spawn_type == SpawnType.Instant and spawn_behavior == SpawnBehavior.Sequence:
		debug_log_string = "NO NO NO INFINITE LOOP CANT HAVE SPAWN TYPE INSTANT AND SPAWN BEHAVIOR SEQUENCE"
		GameManager.quit_game()
	
	if possible_objects_to_spawn.size() == 0:
		debug_log_string = "FAILED NO OBJECTS SET TO SPAWN"
		GameManager.quit_game()
	
	if spawn_type in [SpawnType.Instant_Timer, SpawnType.On_Signal_Timer]:
		timer = Timer.new()
		timer.connect("timeout", spawn)
		add_child(timer)
		
		
		if spawn_type == SpawnType.Instant_Timer:
			timer.start(time_out)
		
		debug_log_string = "TIMER SETUP COMPLETE"
	
	if spawn_type == SpawnType.Instant:
		call_deferred("spawn") 

func spawn() -> Node2D:
	if timer != null and loop:
		timer.start(time_out)
	
	var object_to_spawn : PackedScene
	
	match spawn_behavior:
		SpawnBehavior.First_Object_Only:
			object_to_spawn = possible_objects_to_spawn[0]
		
		SpawnBehavior.Sequence:
			object_to_spawn = possible_objects_to_spawn[current_spawn_object]
			current_spawn_object += 1
		
		SpawnBehavior.Random:
			if possible_objects_to_spawn.size() == 1: #DEBUG
				debug_log_string = 'ONLY GOT ONE OBJECT SON WHY RANDOMIZE??????'
			
			object_to_spawn = possible_objects_to_spawn[randi_range(0, possible_objects_to_spawn.size())]
	
	var new_object : Node2D = object_to_spawn.instantiate()
	new_object.global_transform = global_transform
	get_tree().current_scene.add_child(new_object)
	debug_log_string = "SPAWNED " + new_object.name
	object_spawned.emit(new_object)
	return new_object

func start_spawn_timer():
	debug_log_string = "TIMER STARTER"
	timer.start(time_out)
