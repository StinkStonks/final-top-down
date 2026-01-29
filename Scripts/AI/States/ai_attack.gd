extends AIState
class_name AI_Attack

func enter():
	print("Entered ATTACK")

func update(delta):
	if not is_instance_valid(character.target):
		state_machine.change_state("Idle")
		return

	if character.global_position.distance_to(character.target.global_position) > character.attack_range:
		state_machine.change_state("Chase")
		return
	
	print("Attacking!")
