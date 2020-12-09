extends RigidBody

export(float) var impulse_magnitude := 10.0

func _ready():
	var direction = Vector3.UP 
	apply_central_impulse(direction * impulse_magnitude)
