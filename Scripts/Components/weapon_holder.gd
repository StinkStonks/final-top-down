extends Node2D
class_name WeaponHolder

@onready var graphics : Sprite2D = $Sprite2D
@onready var firing_point : Node2D = $FiringPoint

@export var current_weapon : WeaponData
@export var backpack_weapon : WeaponData

var can_switch : bool = true
var can_shoot : bool = true
var bullets_shot : int = 0

signal switched_weapon(weapon:WeaponData)
signal shot_fired(weapon:WeaponData)
signal update_ui(weapon:WeaponData)
signal dry_fire

func _ready() -> void:
	if current_weapon:
		current_weapon = current_weapon.duplicate()
	
	if backpack_weapon:
		backpack_weapon = backpack_weapon.duplicate()
	
	update_graphics()

func switch_weapon():
	if !can_switch:
		return
	
	if backpack_weapon == null:
		return
	
	var temp : WeaponData = current_weapon
	current_weapon = backpack_weapon
	backpack_weapon = temp
	
	update_graphics()

func update_graphics():
	if current_weapon == null:
		graphics.texture = null
		graphics.offset = Vector2.ZERO
		return
	graphics.texture = current_weapon.texture
	graphics.offset = current_weapon.offset
	switched_weapon.emit(current_weapon)
	update_ui.emit(current_weapon)

func reload_weapon():
	if can_reload():
		can_switch = false
		await get_tree().create_timer(current_weapon.reload_time).timeout
		current_weapon.reload()
		can_switch = true
		update_ui.emit(current_weapon)

func can_reload() -> bool:
	if current_weapon.can_reload():
		return true
	return false

func shoot():
	if current_weapon == null: 
		return
	
	if can_shoot and current_weapon.current_ammo > 0:
		can_shoot = false
		can_switch = false
		
		#no idea what I did but it worked
		if current_weapon.burst_size > 0:
			while bullets_shot <= current_weapon.burst_size:
				if bullets_shot != 0:
					await get_tree().create_timer(current_weapon.time_tween_shots).timeout
				
				for i in current_weapon.bullet_count:
					create_bullet(i)
				bullets_shot += 1
				if !current_weapon.Infinite_Ammo: 
					current_weapon.current_ammo -= 1
					update_ui.emit(current_weapon)
		else:
			for i in current_weapon.bullet_count:
				create_bullet(i)
			
			if !current_weapon.Infinite_Ammo: 
				current_weapon.current_ammo -= 1
				update_ui.emit(current_weapon)
		
		shot_fired.emit()
		
		await get_tree().create_timer(1 / current_weapon.fire_rate).timeout
		bullets_shot = 0
		can_switch = true
		can_shoot = true
	else:
		dry_fire.emit()

func create_bullet(i : int):
	var new_bullet : Node2D = current_weapon.bullet_scene.instantiate()
	new_bullet.global_position = $FiringPoint.global_position
	
	if current_weapon.bullet_count == 1:
		new_bullet.global_rotation = $FiringPoint.global_rotation + randf_range(-current_weapon.arc, current_weapon.arc)
	else:
		var arc_rad = deg_to_rad(current_weapon.arc)
		var increment = arc_rad / (current_weapon.bullet_count - 1)
		
		new_bullet.global_rotation = (
			global_rotation + randf_range(-current_weapon.arc, current_weapon.arc) +
			increment * i - 
			arc_rad / 2
		)
	
	if current_weapon.override_damage_amount != 0:
		new_bullet.damage = current_weapon.override_damage_amount
	
	get_tree().current_scene.add_child(new_bullet)

func get_weapon(data : WeaponData) -> WeaponData:
	if current_weapon == data:
		return current_weapon
	elif backpack_weapon == data:
		return backpack_weapon
	return null

func set_weapons(current_data : WeaponData, backpack_data : WeaponData):
	if current_data != null:
		current_weapon = current_data
	if backpack_data != null:
		backpack_weapon = backpack_data
	update_graphics()

func add_weapon(data : WeaponData):
	if backpack_weapon == null and current_weapon != null:
		backpack_weapon = data.duplicate()
	else:
		current_weapon = data.duplicate()
	update_graphics()
