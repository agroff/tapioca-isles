extends StaticBody3D

@onready var teapot_ui: Control = $StatusLabel/SubViewport/TeapotUi

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_prompt_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		teapot_ui.show()


func _on_prompt_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		teapot_ui.hide()
