extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $knight/AnimationPlayer
#@onready var animation_player: AnimationPlayer = $player/AnimationPlayer
@onready var weapon_slot: BoneAttachment3D = $knight/Armature/GeneralSkeleton/WeaponSlot

const run_anim = "knight/run"
const attack_anim = "knight/attack slash"
const idle_anim = "knight/idle"
#const run_anim = "charge"
#const attack_anim = "attack"
#const idle_anim = "idle"

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const rotation_speed = 1.5

var is_backswing = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var mouse_motion := Vector2.ZERO

var attacking := false
var dodging := false

func _ready() -> void:
	SceneManager.settings.settings_closed.connect(settings_closed)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func settings_closed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		pass
		#velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#if Input.is_action_just_pressed("attack") and attacking:
		#animation_player.seek(0.3, true)
	#if Input.is_action_just_pressed("attack") and not attacking:
		#attacking = true
	if Input.is_action_just_pressed("attack"):
		attacking = true
		is_backswing = not is_backswing

	

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	

	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var speed = SPEED
	if input_dir.y > 0.5: speed = 2.0
	elif input_dir.y == 0: speed = 3.5
	if attacking: speed = 1.1
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	elif dodging:
		velocity.x = move_toward(velocity.x, 0, 3)
		velocity.z = move_toward(velocity.z, 0, 3)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		
	if Input.is_action_just_pressed("dodge") and is_on_floor():
		dodging = true
		var dir = transform.basis * Vector3(0,0,20)
		velocity.x = dir.x
		velocity.z = dir.z
		velocity.y = 2

	#print({"direction": direction, "velocity": velocity})
	#print("X: " + str(input_dir.x))
	#print("Y: " + str(input_dir.y))
	# Animation
	if dodging:
		animation_player.play("knight/jump2 short", 0.2)
	elif attacking:
		animation_player.speed_scale = 1.8
		if is_backswing:
			animation_player.play("knight/attack backhand", 1)
		else:
			animation_player.play(attack_anim, 1)
	elif not is_on_floor(): 
		animation_player.play("knight/jump")
	elif velocity.x == 0:
		animation_player.speed_scale = 1
		if mouse_motion.x > 0:
			animation_player.play("knight/turn right", 0.1)
		elif mouse_motion.x < 0:
			animation_player.play("knight/turn left", 0.1)
		else:
			animation_player.play(idle_anim, 0.2)
	else:
		animation_player.speed_scale = 0.8
		if input_dir.y > 0.5:
			animation_player.play("knight/run backward")
		elif input_dir.y == 0:
			if input_dir.x > 0:
				animation_player.play("knight/run strafe right")
			else:
				animation_player.play("knight/run strafe left")
		else:
			animation_player.play(run_anim)
	
	handle_camera_rotation()
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ALT): return
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			mouse_motion = -event.relative * 0.001
	if event.is_action("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func handle_camera_rotation() -> void:
	rotate_y(mouse_motion.x)
#	rotate_x(mouse_motion.y)
#	rotation_degrees.x = clampf(rotation_degrees.x, -90.0, 90.0)
	mouse_motion = Vector2.ZERO


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "knight/jump2 short": dodging = false
	if anim_name == "knight/attack backhand": attacking = false
	if anim_name == attack_anim: attacking = false

func activateWeapon():
	weapon_slot.get_child(0).activate()
	
func deactivateWeapon():
	weapon_slot.get_child(0).deactivate()
