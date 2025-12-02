extends Interactable
class_name InteractableWeapon

@onready var sprite2d : Sprite2D = $Sprite2D

@export var weapon_data : WeaponData

@export_group("Overrides")
@export var current_ammo_override : int = -1
@export var reserve_ammo_override : int = -1

func _ready() -> void:
	weapon_data = weapon_data.duplicate()
	interactable_name = weapon_data.resource_name
	sprite2d.texture = weapon_data.texture
	
	if current_ammo_override != -1:
		weapon_data.current_ammo = current_ammo_override
	
	if reserve_ammo_override != -1:
		weapon_data.reserve_ammo = reserve_ammo_override
	

func interact(player : Player):
	var weapon_holder : WeaponHolder = player.weapon_holder
	if weapon_holder.get_weapon(weapon_data) != null:
		var local_weapon : WeaponData = weapon_holder.get_weapon(weapon_data)
		local_weapon.reserve_ammo += weapon_data.reserve_ammo + weapon_data.current_ammo
		print(local_weapon.reserve_ammo)
	else:
		player.weapon_holder.add_weapon(weapon_data)
	super(player)
