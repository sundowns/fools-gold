extends Spatial

export(String) var scene_path
export(NodePath) var parent_node_path
var spawner_scene: PackedScene = null
var parent_node: Node = null

func _ready():
	assert(scene_path != null, "Spawner missing scene_path..")
	assert(parent_node_path != null, "Spawner missing parent node path")
	parent_node = get_node(parent_node_path)
	assert(parent_node != null, "Failed to find delegated parent_node for spawner: %s" % parent_node_path)
	spawner_scene = load(scene_path)
	assert(spawner_scene != null, "Failed to load delegated scene_path for spawner: %s" % scene_path)

func spawn():
	var new_thing: Node = spawner_scene.instance()
	parent_node.add_child(new_thing)
	new_thing.global_transform = global_transform
