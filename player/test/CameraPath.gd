extends Path3D

@onready var camera_follow: PathFollow3D = $CameraFollow

var distance = 10
var speed = 3

var mouse_motion := Vector2.ZERO
var target = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = camera_follow.progress_ratio


func _input(event: InputEvent) -> void:
	if not event is InputEventMouseMotion: return
	if not Input.is_key_pressed(KEY_ALT): return
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		mouse_motion = -event.relative * 0.001


func handle_camera_rotation() -> void:
	if mouse_motion.x == 0:
		pass
		#rotate_y(move_toward(rotation.y, 180, 0.002))
	else:
		rotate_y(mouse_motion.x)
#	rotate_x(mouse_motion.y)
#	rotation_degrees.x = clampf(rotation_degrees.x, -90.0, 90.0)
	mouse_motion = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var ratio = camera_follow.progress_ratio
	if Input.is_action_just_released("camera_zoom_in"):
		target = clamp(ratio - (delta * distance), 0.05, 0.95)
	if Input.is_action_just_released("camera_zoom_out"):
		target = clamp(ratio + (delta * distance), 0.05, 0.95)
		
	camera_follow.progress_ratio = lerpf(ratio,target, delta * speed)
	handle_camera_rotation()
