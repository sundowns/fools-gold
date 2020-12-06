extends Spatial
class_name GroundCheck

var raycasts = []

func _ready():
	for child in get_children():
		if child is RayCast:
			raycasts.append(child)

func is_grounded() -> bool:
	var grounded = false
	for ray in raycasts:
		if ray.is_colliding():
			grounded = true
			break
	return grounded
