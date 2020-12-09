extends Spatial

export(String) var scene_path
export(NodePath) var parent_node_path
var spawner_scene: PackedScene = null
var parent_node: Node = null

export(bool) var intermittently_spawn := false
export(int) var max_spawn_count := -1
export(float) var spawn_interval := 5.0
export(bool) var is_active := true
var spawn_count = 0

onready var spawn_timer: Timer = $Timer

func _ready():
	assert(scene_path != null, "Spawner missing scene_path..")
	assert(parent_node_path != null, "Spawner missing parent node path")
	parent_node = get_node(parent_node_path)
	assert(parent_node != null, "Failed to find delegated parent_node for spawner: %s" % parent_node_path)
	spawner_scene = load(scene_path)
	assert(spawner_scene != null, "Failed to load delegated scene_path for spawner: %s" % scene_path)
	if intermittently_spawn and is_active:
		spawn_timer.start(spawn_interval)

func activate():
	is_active = true
	if intermittently_spawn:
		spawn_timer.start(spawn_interval)

func spawn():
	if not is_active:
		return
	if max_spawn_count != -1 and spawn_count >= max_spawn_count:
		return
	var new_thing: Node = spawner_scene.instance()
	parent_node.add_child(new_thing)
	new_thing.global_transform = global_transform
	spawn_count += 1

func _on_Timer_timeout():
	spawn()
	if spawn_count < max_spawn_count:
		spawn_timer.start(spawn_interval)
