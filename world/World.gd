extends Spatial

onready var spawn_point: Position3D = $PlayerSpawnPoint
onready var effects: Node = $Effects

func _ready():
	Global.world_node = self
	Global.navigation_map = get_node("Navigation")
	var player = spawn_player()
	player.call_deferred("initialise")

func spawn_player():
	var player = load("res://entities/Player.tscn").instance()
	add_child(player)
	player.global_transform = spawn_point.global_transform
	return player

func add_effect(instanced_scene: Node):
	effects.add_child(instanced_scene)

func _exit_tree():
	Global.world_node = null
	Global.navigation_map = null
