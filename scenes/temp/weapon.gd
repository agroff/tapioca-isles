extends Node3D

@onready var area_3d: Area3D = $Area3d
var can_damage = false

const damage := 75.0

var activeArea: Area3D

func _ready() -> void:
	can_damage = false

func _process(delta: float) -> void:
	if can_damage and activeArea != null:
		activeArea.get_parent().applyDamage(damage)
		# deactivate until next activation
		can_damage = false

func activate():
	can_damage = true

func deactivate():
	can_damage = false


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("damageable"):
		activeArea = area


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("damageable"):
		activeArea = null
