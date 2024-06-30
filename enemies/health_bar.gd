extends Node3D

@onready var progress_bar: ProgressBar = $SubViewport/ProgressBar

var totalHealth: float
var currentHealth: float

func setTotalHealth(health: float):
	totalHealth = health
	currentHealth = health
	updateBar()

func setCurrentHealth(health: float):
	currentHealth = health
	updateBar()
	

func updateBar():
	if currentHealth == totalHealth: hide()
	else: show()
	progress_bar.max_value = totalHealth
	progress_bar.value = currentHealth

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
