extends BTAction

@export var animation_name: String

func _tick(delta: float) -> Status:
	print("playing", animation_name)
	agent.play_animation(animation_name)
	return SUCCESS
	 
