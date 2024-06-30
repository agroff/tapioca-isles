extends RigidBody3D

@export var item: Item

func _ready():
	freeze = true
	
func spawn(pos: Vector3):
	freeze = false
	global_position = pos + (Vector3.UP * 2)
	var force = Vector3(randf()*2, 3, randf()*2)
	apply_impulse(force)
	
func reset():
	global_position = Vector3.ZERO
	freeze = true

func _on_loot_item_collected() -> void:
	reset()
