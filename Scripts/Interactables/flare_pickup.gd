extends Interactable
class_name FlarePickup

@export var amount : int = 1

func interact(player : Player):
	if player.flare_component.empty_flare_slots() > 0:
		var temp : int = amount
		amount -= player.flare_component.empty_flare_slots()
		player.flare_component.add_flare(temp) 
	
	print(amount)
	if amount <= 0:
		queue_free()
