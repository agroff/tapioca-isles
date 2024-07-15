extends BTAction

@export var target_var: StringName = &"target"

func _tick(p_delta: float) -> Status:
	var nodes = agent.get_tree().get_nodes_in_group("player")
	if nodes.size() == 0:
		return FAILURE
	blackboard.set_var(target_var, nodes[0])
	return SUCCESS
	
