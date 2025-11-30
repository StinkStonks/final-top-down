extends Resource
class_name WeaponData

@export var texture : Texture2D
@export var offset : Vector2 = Vector2.ZERO
@export var bullet_scene : PackedScene

@export_group("Firing Properties")
@export var bullet_count : int = 1
@export_range(0, 1) var arc : float = 0
@export_range(0, 20) var fire_rate : float = 2

@export_group("Burst Properties")
@export var burst_size : int = 1
@export_range(0, 1) var time_tween_shots : float = 0.2

@export_group("Ammo Properties")
@export var reload_time : float = 0.1
@export var reserve_ammo : int = 100
@export var current_ammo : int = 32
@export var max_ammo : int = 32

@export_group("Overrides")
@export_range(0, 1) var override_damage_amount : int = 0
@export var Infinite_Ammo : bool = false

var initial_current_ammo : int 
var initial_reserve_ammo : int 

func reset_weapon():
	current_ammo = initial_current_ammo
	reserve_ammo = initial_reserve_ammo

func get_ammo() -> String:
	var base = '{CurrentAmmo}/{MagSize}\n{ReserveAmmo}'
	return base.format({
		'CurrentAmmo' : current_ammo,
		'MagSize' : max_ammo,
		'ReserveAmmo' : reserve_ammo
		})

func can_reload() -> bool:
	if current_ammo < max_ammo:
		return true
	return false

func reload():
	reserve_ammo += current_ammo
	current_ammo = 0
	
	if reserve_ammo > max_ammo:
		current_ammo = max_ammo
	else:
		current_ammo = reserve_ammo
	
	reserve_ammo -= current_ammo
