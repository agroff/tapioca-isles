extends Enemy
@onready var animation_player: AnimationPlayer = $"sugar-rigged/AnimationPlayer"

func _init():
	health = 200

func childReady() -> void:
	animation_player.play("Brute-library/idle standing")
	animation_player.seek(randf() * 1.5)

func childDie() -> void:
	animation_player.play("knight/die backward")
