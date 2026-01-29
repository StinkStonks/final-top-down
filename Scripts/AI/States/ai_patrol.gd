extends AIState

func enter():
	print("Entered PATROL")

func update(delta):
	character.position.x += character.move_speed * delta

	if character.target and character.global_position.distance_to(character.target.global_position) <= character.detection_range:
		state_machine.change_state("Chase")
