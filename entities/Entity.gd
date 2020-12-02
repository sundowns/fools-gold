extends KinematicBody
class_name Entity

export(float) var gravity: float = 10
export(float) var falling_gravity_modifier: float = 1.0
export(float) var max_health: float = 200

const terminal_fall_velocity: float = -40.0

onready var health = max_health

var gravity_vector := Vector3.ZERO
var velocity := Vector3.ZERO

#func handle_ceiling_bonk():
#	if is_on_ceiling() and gravity_vector.y > 0:
#		gravity_vector.y = 0
