extends Entity
class_name Player

onready var head: Spatial = $Head
onready var camera: Camera = $Head/Camera
onready var hand: Spatial = $Head/Hand

# Player movement values
export var ground_speed: float = 10
export var ground_acceleration: float = 16
export var jump_force: float = 7 # Initial vertical impulse when jumping

export var aerial_speed: float = 13
export var aerial_acceleration: float = 2.75 # 4.5 juicy but quite high
export var aerial_drag: float = 6

const strafe_viewport_rotation_speed := deg2rad(25)
const max_strafe_viewport_rotation := deg2rad(0.75)
#const weapon_sway := 35

var strafe_viewport_rotation = 0
var direction = Vector3.ZERO

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * Global.mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * Global.mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))

func initialise():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	handle_viewport_lean(delta)

func _physics_process(delta):
	apply_gravity(delta)

func grounded_movement(delta: float):
	direction = Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	elif Input.is_action_pressed("move_right"):
		direction += transform.basis.x

	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * ground_speed, ground_acceleration * delta)

func aerial_movement(delta):
	direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	elif Input.is_action_pressed("move_right"):
		direction += transform.basis.x
		
	direction = direction.normalized()
	if direction != Vector3.ZERO:
		velocity = velocity.linear_interpolate(direction * aerial_speed, aerial_acceleration * delta)
	velocity = velocity.move_toward(Vector3(0, velocity.y, 0), delta * aerial_drag)
	.handle_ceiling_bonk()

func handle_jump():
	if Input.is_action_pressed("jump"):
		if is_on_floor(): # or is_grounded():
			jump()
	

func jump(height_modifier: float = 1.0):
	gravity_vector = Vector3.UP * jump_force * height_modifier

func handle_viewport_lean(delta):
	if Input.is_action_pressed("move_left"):
		strafe_viewport_rotation += strafe_viewport_rotation_speed * delta
	elif Input.is_action_pressed("move_right"):
		strafe_viewport_rotation -= strafe_viewport_rotation_speed * delta
	elif strafe_viewport_rotation != 0:
		strafe_viewport_rotation = strafe_viewport_rotation * 0.975 * delta

	strafe_viewport_rotation = clamp(strafe_viewport_rotation, -max_strafe_viewport_rotation, max_strafe_viewport_rotation)
	camera.rotation.z = strafe_viewport_rotation
