@tool
extends Node2D
class_name SpawnPoint

@onready var zombie_pool : ZombiePool = get_tree().current_scene.get_node("ZombiePool")
@export var amount : int = 20
@export var radius : float = 30

func spawn_zombies():
	zombie_pool.spawn_zombies(amount, global_position, radius)

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_circle(Vector2.ZERO, radius, Color.DARK_RED, false, 1.0, false)
