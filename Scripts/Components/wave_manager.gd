extends Node
class_name WaveManager

#Honestly dont know if this is the best way to program this...
@export var spawn_data : SpawnData

func _ready() -> void:
	print(spawn_data.get_random_object_from_pool())
