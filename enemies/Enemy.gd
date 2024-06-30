class_name Enemy
extends CharacterBody3D

@onready var health_bar: Node3D = $HealthBar

@export var lootTable: LootTable

var health := 100.0
var dead = false
var decay = false

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

func applyDamage(damage: float):
	health = max(health - damage, 0)
	health_bar.setCurrentHealth(health)
	if health == 0:
		die()
		
func die():
	dead = true
	health_bar.hide()
	childDie()
	#LootManager.reportDeath("taro", global_position)
	LootManager.generateLoot(lootTable, global_position)
	await get_tree().create_timer(3.0).timeout
	decay = true

func childDie():
	pass
