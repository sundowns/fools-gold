extends Spatial

# Initialise to spatial placeholder
onready var current_world = $WorldScenePlaceHolder

func _ready():
	var starting_world = load("res://world/levels/E1M1.tscn")
	load_world(starting_world)

func load_world(new_world_scene: PackedScene):
	# unload currently loaded world if it exists
	if current_world:
		remove_child(current_world)
		current_world.queue_free()
		current_world = null
	current_world = new_world_scene.instance()
	add_child(current_world)
