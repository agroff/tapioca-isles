extends Enemy
@onready var animation_player: AnimationPlayer = $"sugar-rigged/AnimationPlayer"
@onready var collision_shape: CollisionShape3D = $CollisionShape
@onready var sugar_projectile: Node3D = $"sugar-rigged/Armature/GeneralSkeleton/ProjectileLauncher/SugarProjectile"
@onready var sugar_rigged: Node3D = $"sugar-rigged"


func _init():
	health = 200

func childReady() -> void:
	pass
	#animation_player.play("Brute-library/idle standing")
	#animation_player.seek(randf() * 1.5)

func childDie() -> void:
	animation_player.play("knight/die backward")
	collision_shape.disabled = true

func launchProjectile() -> void:
	#sugar_projectile.throw()
	var launcher = sugar_projectile.get_parent()
	var new_projectile: Node3D = sugar_projectile.duplicate()
	launcher.add_child(new_projectile)
	
	new_projectile.global_position = launcher.global_position
	new_projectile.global_rotation = global_rotation + Vector3(0,1.45,0)
	print(global_rotation)
	new_projectile.throw()
	new_projectile.top_level = true
