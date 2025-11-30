extends Node2D
class_name HealthComponent

@onready var raycast2D : RayCast2D = $RayCast2D

@export var max_health : float = 100
var current_health : float = max_health

@export var blood_burst : PackedScene
@export var blood_small : PackedScene 

signal damaged
signal healed
signal health_changed(new_amount:float, new_max_health:float)
signal died

func take_damage(damage_data : DamageData):
	current_health = clampf(current_health - damage_data.amount, 0, max_health)
	spawn_decal(damage_data.hit_direction, 1)
	
	if current_health <= 0:
		died.emit()
	else:
		damaged.emit()
	
	health_changed.emit(current_health, max_health)

func heal(amount : float) -> void:
	current_health = clampf(current_health + amount, 0, max_health)
	healed.emit()
	health_changed.emit(current_health, max_health)

func set_health(amount : float) -> void:
	current_health = amount
	health_changed.emit(current_health, max_health)
	
	if current_health <= 0:
		died.emit()

func spawn_decal(direction : float, force : float):
	var decal_spawn_location : Vector2 = Vector2.ZERO
	
	var new_decal : Node2D = blood_small.instantiate()
	new_decal.global_position = global_position
	
	get_tree().current_scene.add_child(new_decal)
