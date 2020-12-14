extends Spawner

onready var rng = RandomNumberGenerator.new()

func _ready():
	var has_position_child := false
	for child in get_children():
		if child is Position3D:
			has_position_child = true
	assert(has_position_child, "MultiSpawner exists without any Position3D children.")

func spawn():
	spawn_transform = get_random_position_child()
	.spawn()

func get_random_position_child():
	var child = null
	while child == null:
		var new_child = get_child(rng.randi_range(0, get_child_count() -1))
		if new_child is Position3D:
			child = new_child
	return child.global_transform
