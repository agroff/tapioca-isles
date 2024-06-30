extends CanvasLayer
@onready var loading_screen_bg: ColorRect = $LoadingScreenBg

func fadeIn() -> void:
	await loading_screen_bg.fadeIn()
	
func fadeOut() -> void:
	await loading_screen_bg.fadeOut()
