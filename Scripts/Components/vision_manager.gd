extends Node2D
class_name VisionManager

@onready var player : Player = get_tree().get_first_node_in_group('player')
@onready var ray_cast : RayCast2D = $RayCast2D

func player_spotted() -> bool:
	look_at(player.global_position)
	
	ray_cast.force_raycast_update()
	if ray_cast.is_colliding():
		var col : Node2D = ray_cast.get_collider()
		if col == player:
			return true
			
	return false
