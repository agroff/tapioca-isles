extends Node3D

@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var progress_bar: ProgressBar = $SubViewport/ProgressBar
@onready var damage_number: Node3D = $DamageNumber

var dmgLeft = false
var totalHealth: float
var currentHealth: float

func setTotalHealth(health: float):
	totalHealth = health
	currentHealth = health
	updateBar()

func setCurrentHealth(health: float):
	currentHealth = health
	updateBar()

func showDamage(damage: int):
	dmgLeft = not dmgLeft
	var dmg = damage_number.duplicate()
	add_child(dmg)
	dmg.visible = true
	var label = dmg.get_child(0)
	label.text = str(damage)
	if dmgLeft: label.position.x -= 0.5
	else: label.position.x += 0.5

	dmg.get_child(1).play("damage_text_anim")
	await get_tree().create_timer(2.0).timeout
	dmg.queue_free()

func updateBar():
	if currentHealth == totalHealth: hide()
	elif currentHealth == 0: sprite_3d.hide()
	else: show()
	progress_bar.max_value = totalHealth
	progress_bar.value = currentHealth

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage_number.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
