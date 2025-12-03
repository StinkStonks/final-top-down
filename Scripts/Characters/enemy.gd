extends Character
class_name Enemy

@onready var player : Player = get_tree().get_first_node_in_group('player')
@onready var agent : NavigationAgent2D = $NavigationAgent2D

var current_path_point : int = 0

func _process(delta: float) -> void:
	super(delta)

func _physics_process(delta: float) -> void:
	super(delta)

func control_character_body() -> Vector2:
	var output : Vector2 = Vector2.ZERO #X Turn Y Move
	
	if set_target_position(player.global_position):
		var angle_to_next_position : float = (agent.get_next_path_position() - global_position).angle()
		var angle_diff : float = abs(angle_to_next_position - global_rotation)
		
		angle_diff = abs(wrapf(angle_diff, -PI, PI))
		
		if angle_diff < deg_to_rad(11):
			print("facing")
		
		output.x = angle_diff
		output.y = 1
	
	return output

func control_character_head() -> Vector2:
	return Vector2.ZERO

func set_target_position(pos : Vector2) -> bool:
	agent.target_position = pos
	return agent.is_target_reachable()
