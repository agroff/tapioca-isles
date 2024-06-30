extends Area3D

signal collected

@export var item: Item

@onready var collect_sound: AudioStreamPlayer = $CollectSound

func collect():
	collect_sound.play()
	emit_signal("collected")
	#reset()


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		Inventory.addItem(item, 1)
		collect()
