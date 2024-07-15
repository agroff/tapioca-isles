class_name Enemy
extends CharacterBody3D

@onready var health_bar: Node3D = $HealthBar
@onready var anim: AnimationPlayer = %AnimationPlayer

@export var speed := 2.0
@export var lootTable: LootTable

var health := 100.0
var dead = false
var decay = false

var target_pos = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.setTotalHealth(health)
	childReady()

func childReady() -> void:
	pass
	
func _process(delta: float) -> void:
	if decay:
		global_position.y -= delta
	if global_position.y < -4:
		queue_free()

func _physics_process(delta: float) -> void:
	
	#var direction := (transform.basis * target_pos).normalized()
	var direction := (transform.basis * Vector3(0, 0, -1)).normalized()
	#print(target_pos, global_position)
	if target_pos == Vector3.ZERO:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	else:
		var pos_vector = global_position.direction_to(target_pos)
		var pos_basis = Basis.looking_at(pos_vector)
		basis = basis.slerp(pos_basis, delta)
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

	move_and_slide()

func applyDamage(damage: float):
	if dead: return
	health = max(health - damage, 0)
	health_bar.setCurrentHealth(health)
	health_bar.showDamage(damage)
	if health == 0:
		die()
		
func play_animation(animation: String):
	anim.play(animation)

func stop():
	target_pos = Vector3.ZERO

func move_towards(pos: Vector3):
	target_pos = pos
	
func die():
	dead = true
	#health_bar.hide()
	childDie()
	#LootManager.reportDeath("taro", global_position)
	LootManager.generateLoot(lootTable, global_position)
	await get_tree().create_timer(3.0).timeout
	decay = true

func childDie():
	pass
