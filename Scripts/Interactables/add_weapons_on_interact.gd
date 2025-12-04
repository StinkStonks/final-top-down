extends Interactable
class_name AddWeaponsOnInteract

@export var current_weapon_data : WeaponData 
@export var backpack_weapon_data : WeaponData 

func interact(player : Player):
	player.weapon_holder.set_weapons(current_weapon_data, backpack_weapon_data)
	super(player)
