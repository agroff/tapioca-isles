extends Node3D

@export_file("*.tscn") var teleport_to




func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and teleport_to != null:
		SceneManager.load_scene(teleport_to)
