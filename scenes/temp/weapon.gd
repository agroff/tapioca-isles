extends Node3D

@onready var area_3d: Area3D = $Area3d
var can_damage = false
@onready var whoosh_a: AudioStreamPlayer = $WhooshA
@onready var whoosh_b: AudioStreamPlayer = $WhooshB

const damage := 75.0
const critChance = 0.07

var activeArea: Area3D

func _ready() -> void:
	can_damage = false

func _process(delta: float) -> void:
	if can_damage and activeArea != null:
		var dmg = get_damage()
		activeArea.get_parent().applyDamage(dmg)
		# deactivate until next activation
		can_damage = false

func get_damage():
	var rnd = (randf() - 0.5) * 0.1
	return floorf(damage * (1 + rnd))

func activate():
	var rnd = randf()
	if rnd < 0.5: whoosh_a.play()
	else: whoosh_b.play()
	can_damage = true

func deactivate():
	can_damage = false


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("damageable"):
		activeArea = area


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("damageable"):
		activeArea = null
