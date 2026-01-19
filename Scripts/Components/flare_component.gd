extends Node2D
class_name FlareComponent

@export var starting_flares : int = 3
@export var max_flares : int = 3
@export var throw_force : float = 500
@export var throw_angular_force : float = 5
var current_flares : int = starting_flares

signal flare_thrown
signal flare_count_changed(current_amount : int, max_flares)

func _ready() -> void:
	call_deferred('deffered_ready')

func deffered_ready():
	flare_count_changed.emit(current_flares, max_flares)

func throw_flare(direction : Vector2):
	if !has_flares():
		return
	
	var new_flare = create_flare()
	new_flare.linear_velocity = Vector2.ZERO
	new_flare.angular_velocity = throw_angular_force
	new_flare.apply_impulse(direction.normalized() * throw_force)
	
	current_flares -= 1
	flare_thrown.emit()
	flare_count_changed.emit(current_flares, max_flares)

func add_flare(amount : int):
	current_flares = clamp(current_flares + amount, 0, max_flares)
	flare_count_changed.emit(current_flares, max_flares)

func create_flare() -> Flare:
	var new_flare = preload("res://Prefabs/flare.tscn").instantiate()
	new_flare.global_position = global_position
	get_tree().current_scene.add_child(new_flare)
	return new_flare

func has_flares() -> bool:
	if current_flares <= 0:
		return false
	return true

func empty_flare_slots() -> int:
	return max_flares - current_flares
