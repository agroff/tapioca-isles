extends BTAction

@export var position_var: StringName = &"pos"

@export var speed_var := 2.0
@export var tolerance := 1.5   

func _tick(delta: float) -> Status:
	var pos: Vector3 = blackboard.get_var(position_var, Vector3.ZERO)
	var distance = pos.distance_to(agent.global_position)

	if distance < tolerance:
		agent.stop()   
		return SUCCESS 
	agent.move_towards(pos) 
	return RUNNING 
 
