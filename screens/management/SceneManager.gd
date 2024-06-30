extends Control

@onready var settings: CanvasLayer = $Settings
@onready var loading_screen: CanvasLayer = $LoadingScreen
@onready var music_manager: AudioStreamPlayer = $MusicManager
@onready var playback: AudioStreamPlaybackInteractive = music_manager.get_stream_playback()

func load_scene(scene: String) -> void:
	playback.switch_to_clip(2)
	await loading_screen.fadeIn()
	LootManager.reset()
	get_tree().change_scene_to_file(scene)
	await loading_screen.fadeOut()

func open_settings() -> void:
	settings.show()
