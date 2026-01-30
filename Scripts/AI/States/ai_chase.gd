extends AIState
class_name AI_Chase

func enter():
	print("Entered CHASE")

func update(delta):
	if not is_instance_valid(character.target):
		state_machine.change_state("Idle")
		return

	var dir : Vector2 = (character.target.global_position - character.global_position).normalized()
	character.position += dir * character.speed * delta

	if character.global_position.distance_to(character.target.global_position) <= character.attack_range:
		state_machine.change_state("Attack")
