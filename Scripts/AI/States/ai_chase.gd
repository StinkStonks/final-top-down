extends AIState
class_name AI_Chase

var target_lost : bool = false
var target_last_position : Vector2 = Vector2.ZERO

func enter():
	target_lost = false
	print("Entered CHASE")

func update(delta):
	if not is_instance_valid(character.target):
		state_machine.change_state("Idle")
		return
	var dir : Vector2
	
	if target_lost:
		dir = (target_last_position - character.global_position).normalized()
		if character.global_position.distance_to(target_last_position) <= 1:
			state_machine.change_state("Idle")
	else:
		dir = (character.target.global_position - character.global_position).normalized()
	
	character.position += dir * character.speed * delta
	
	if character.global_position.distance_to(character.target.global_position) <= character.attack_range:
		state_machine.change_state("Attack")

func _target_lost():
	target_lost = true
	target_last_position = character.target.global_position
