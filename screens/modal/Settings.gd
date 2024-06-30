extends CanvasLayer

signal settings_closed

@onready var control: Control = $Control
@onready var language_select: OptionButton = $Control/Panel/GridContainer/LanguageSelect


var languages = [
	"en", "es", "ko"
]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		print("escape pressed")
		open()
		
#func _input(event: InputEvent) -> void:
	#if event.is_action("ui_cancel"):
		#open()

func _ready() -> void:
	# hide on load
	hide()
	
	# set current locale
	var locale = TranslationServer.get_locale()
	var i = languages.find(locale)
	if i == -1:
		i = 0
	language_select.select(i)

func _on_language_select_item_selected(index: int) -> void:
	TranslationServer.set_locale(languages[index])

func _on_settings_okay_btn_pressed() -> void:
	hide()
	emit_signal("settings_closed")

func open() -> void:
	show()

func _on_fullscreen_check_toggled(button_pressed: bool) -> void:
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
