extends Enemy
class_name ZombieBloater

func _process(_delta: float) -> void:
	graphics.look_at(agent.get_next_path_position())
	
func control_motion(_delta : float) -> void:
	var direction = to_local(agent.get_next_path_position()).normalized()
	velocity = direction * speed
	move_and_slide()

func update_ai() -> void:
	if player_position_always_known:
		agent.target_position = get_tree().get_first_node_in_group('player').global_position
