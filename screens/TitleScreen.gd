extends Control


# Replace with function body.
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_settings_btn_pressed() -> void:
	SceneManager.open_settings()

func _on_continue_btn_pressed() -> void:
	SceneManager.load_scene("res://scenes/temp/TestSceneA.tscn")
