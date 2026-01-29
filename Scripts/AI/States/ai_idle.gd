extends AIState
class_name AI_Idle

func enter():
	print("Entered IDLE")

func update(delta):
	if character.target and character.global_position.distance_to(character.target.global_position) <= character.detection_range:
		state_machine.change_state("Chase")
