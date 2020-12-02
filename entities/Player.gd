extends Entity
class_name Player

onready var head: Spatial = $Head
onready var camera: Camera = $Head/Camera
onready var hand: Spatial = $Head/Hand

# Player movement values
export var ground_speed: float = 10
export var ground_acceleration: float = 16
export var jump_force: float = 10 # Initial vertical impulse when jumping

const strafe_viewport_rotation_speed := deg2rad(25)
const max_strafe_viewport_rotation := deg2rad(0.75)

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
	if not is_on_floor():
		var gravity_force = Vector3.DOWN * gravity * delta
		if gravity_vector.y < 0:
			gravity_force *= falling_gravity_modifier
		gravity_vector += gravity_force
		gravity_vector.y = max(gravity_vector.y, terminal_fall_velocity)
	# Just ignoring ground-based gravity vector if the entity has JUST been pushed (so it can leave the ground)
	else:
		if is_on_floor():
			gravity_vector = -get_floor_normal() * gravity
		else:
			gravity_vector = -get_floor_normal()
	
	if is_on_floor():
		grounded_movement(delta)
	apply_movement()

func apply_movement():
	var movement = Vector3.ZERO
	movement.z = velocity.z + gravity_vector.z
	movement.x = velocity.x + gravity_vector.x
	movement.y = gravity_vector.y
	move_and_slide(movement, Vector3.UP)

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

func handle_viewport_lean(delta):
	if Input.is_action_pressed("move_left"):
		strafe_viewport_rotation += strafe_viewport_rotation_speed * delta
	elif Input.is_action_pressed("move_right"):
		strafe_viewport_rotation -= strafe_viewport_rotation_speed * delta
	elif strafe_viewport_rotation != 0:
		strafe_viewport_rotation = strafe_viewport_rotation * 0.975 * delta

	strafe_viewport_rotation = clamp(strafe_viewport_rotation, -max_strafe_viewport_rotation, max_strafe_viewport_rotation)
	camera.rotation.z = strafe_viewport_rotation
