extends BTAction

@export var range_min: float = 3.0
@export var range_max: float = 9.0

@export var position_var: StringName = &"pos"

func _tick(delta: float) -> Status:
	var pos: Vector3
	
	var d = randf_range(range_min, range_max)
	var angle = randi_range(0,360)
	var offset = Vector3(d * cos(angle), 0, d * sin(angle))
	
	#var x = randf_range(range_min, range_max)
	#var z = randf_range(range_min, range_max)
	#pos = agent.global_position + Vector3(x, 0, z)
	pos = agent.global_position + offset
	print("Selected position", pos)
	blackboard.set_var(position_var, pos)
	#print(agent.global_position, pos)
	return SUCCESS
