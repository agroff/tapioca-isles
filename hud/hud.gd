extends Control

@onready var inventory: Panel = %Inventory
@onready var health_bar: ProgressBar = $MarginContainer/HBoxContainer/HealthBar

var initial_health
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player: Player = get_tree().get_nodes_in_group("player")[0]
	player.char_health.connect(update_health)
	health_bar.max_value = player.health
	health_bar.value = player.health

func update_health(health:float):
	health_bar.value = health
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
