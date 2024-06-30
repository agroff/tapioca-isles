extends ColorRect

var lerp_weight = 0.08
var fading = "none"

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if fading == "none":
		return
	var mod = get_modulate()
	
	if fading == "in":
		if mod.a > 0.99:
			fading = "none"
			set_modulate(Color(1,1,1,1))
			print("fade in done")
			return
		set_modulate(lerp(mod, Color(1,1,1,1), lerp_weight))

	if fading == "out":
		if mod.a < 0.01:
			fading = "none"
			visible = false
			set_modulate(Color(1,1,1,0))
			print("fade out done")
			return
		set_modulate(lerp(mod, Color(1,1,1,0), lerp_weight))

func fadeIn() -> void:
	set_modulate(Color(1,1,1,0))
	visible = true
	fading = "in"
	print("start fade in")
	while fading == "in":
		await get_tree().create_timer(0.2).timeout

func fadeOut() -> void:
	set_modulate(Color(1,1,1,1))
	visible = true
	fading = "out"
	print("start fade out")
	while fading == "out":
		await get_tree().create_timer(0.2).timeout
