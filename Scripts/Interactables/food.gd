extends Interactable
class_name Food

@export var amount : float = 15

func interact(player : Player):
	player.hunger_component.eat_food(amount)
	queue_free()
