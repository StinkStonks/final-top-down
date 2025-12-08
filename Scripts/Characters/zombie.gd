extends Enemy
class_name Zombie

func _process(_delta: float) -> void:
	graphics.look_at(agent.get_next_path_position())

func control_motion(_delta:float):
	var direction = to_local(agent.get_next_path_position()).normalized()
	velocity = direction * speed
	move_and_slide()

func update_ai():
	var player_spotted : bool = vision_manager.player_spotted()
	var player_position : Vector2 = get_tree().get_first_node_in_group('player').global_position
	
	var desired_target_position : Vector2 = global_position
	
	if player_position_always_known:
		desired_target_position = player_position
	
	if player_spotted and !chasing_player:
		chasing_player = true
		desired_target_position = player_position
	
	elif !player_spotted and chasing_player:
		chasing_player = false
		desired_target_position = global_position

	agent.target_position = desired_target_position
